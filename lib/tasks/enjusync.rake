require 'digest/sha1'

SCRIPT_ROOT = "#{Rails.root.to_s}/script/enjusync"
INIT_BUCKET = "#{SCRIPT_ROOT}/init-bucket.pl"
SEND_BUCKET = "#{SCRIPT_ROOT}/send-bucket.pl"
RECV_BUCKET = "#{SCRIPT_ROOT}/recv-bucket.pl"
GET_STATUS_FILE = "#{SCRIPT_ROOT}/get-statusfile.pl"

DUMPFILE_PREFIX = "/var/enjusync"
PERLBIN = "/usr/bin/perl"
STATUS_FILE = "#{DUMPFILE_PREFIX}/work"

$enju_log_head = ""
$enju_log_tag = ""

def taglogger(msg)
  Rails.logger.info "#{$enju_log_head} #{$enju_log_tag} #{msg}"
  puts "#{$enju_log_head} #{$enju_log_tag} #{msg}"
end

def ftpsyncpush(last_id)
  taglogger "call task [init_backet] start"
  sh "#{PERLBIN} #{INIT_BUCKET} #{last_id}"
  taglogger "call task [init_backet] end"

  taglogger "call task [send_backet] start"
  sh "#{PERLBIN} #{SEND_BUCKET}"
  taglogger "call task [send_backet] end"
end

namespace :enju_trunk do
  namespace :sync do
    desc 'Initial sync'
    task :init => :environment do
      $enju_log_head = "sync::init"
      $enju_log_tag = Digest::SHA1.hexdigest(Time.now.strftime('%s'))[-5, 5]

      taglogger "start #{Time.now}"
      taglogger "init_bucket=#{INIT_BUCKET}"
      taglogger "send_bucket=#{SEND_BUCKET}"

      last_id = Version.last.id
      dumpfiledir = "#{DUMPFILE_PREFIX}/#{last_id}"
      dumpfile = "#{dumpfiledir}/enjudump.yml"

      taglogger "last_id=#{last_id} "
      taglogger "dumpfiledir=#{dumpfiledir} "
      taglogger "dumpfile=#{dumpfile} "

      taglogger "mkdir_p begin"
      FileUtils.mkdir_p(dumpfiledir)
      taglogger "mkdir_p end"

      taglogger "call task [enju::sync::export] start"

      ENV['EXPORT_FROM'] = last_id.to_s
      ENV['DUMP_FILE'] = dumpfile
      Rake::Task["enju:sync:export"].invoke

      taglogger "call task [enju::sync::export] end"

      Dir::chdir(SCRIPT_ROOT)  
      ftpsyncpush(last_id) 

      taglogger "end (NormalEnd)"
    end

    desc 'Scheduled process'
    task :scheduled_export => :environment do
      $enju_head = "sync::scheduled_export"
      $enju_tag = Digest::SHA1.hexdigest(Time.now.strftime('%s'))[-5, 5]

      taglogger "start #{Time.now}"
      taglogger "init_bucket=#{INIT_BUCKET}"
      taglogger "send_bucket=#{SEND_BUCKET}"

      last_id = Version.last.id
      dumpfiledir = "#{DUMPFILE_PREFIX}/#{last_id}"
      dumpfile = "#{dumpfiledir}/enjudump.yml"

      # a.業務側からWebOPAC側に接続し、5)のstatusfileを取得
      Dir::chdir(SCRIPT_ROOT)  
      taglogger "call task [get_status_file] start"
      sh "#{PERLBIN} #{GET_STATUS_FILE}"
      taglogger "call task [get_status_file] end"

      # b.同期番号取得
      last_id = Version.last.id

      # c.同期データを出力
      ENV['STATUS_FILE'] = STATUS_FILE
      ENV['DUMP_FILE'] = dumpfile
      Rake::Task["enju:sync:export"].invoke

      # d.バケット作成, e.データ転送
      Dir::chdir(SCRIPT_ROOT)  
      ftpsyncpush(last_id) 
    end

    desc 'Scheduled process'
    task :scheduled_import => :enviroment do
      Rake::Task["enju:sync:import"].invoke
    end
  end
end
