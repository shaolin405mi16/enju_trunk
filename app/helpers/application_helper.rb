# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  include PictureFilesHelper
  include EnjuBookJacket::BookJacketHelper if defined?(EnjuBookJacket)
  include EnjuManifestationViewer::ManifestationViewerHelper if defined?(EnjuManifestationViewer)
  include EnjuBookmark::BookmarkHelper if defined?(EnjuBookmark)
  include JaDateFormat
  include EnjuTerminalsHelper

  def form_icon(carrier_type)
    case carrier_type.name
    when 'print'
      image_tag('icons/book.png', :size => '16x16', :alt => carrier_type.display_name.localize, :title => carrier_type.display_name.localize)
    when 'CD'
      image_tag('icons/cd.png', :size => '16x16', :alt => carrier_type.display_name.localizei, :title => carrier_type.display_name.localize)
    when 'DVD'
      image_tag('icons/dvd.png', :size => '16x16', :alt => carrier_type.display_name.localizei, :title => carrier_type.display_name.localize)
    when 'file'
      image_tag('icons/monitor.png', :size => '16x16', :alt => carrier_type.display_name.localize, :title => carrier_type.display_name.localize)
    else
      image_tag('icons/help.png', :size => '16x16', :alt => 'unknown', :title => 'unknown')
    end
  rescue NoMethodError
    image_tag('icons/help.png', :size => '16x16', :alt => 'unknown', :title => 'unknown')
  end

  def content_type_icon(content_type)
    case content_type.name
    when 'text'
      image_tag('icons/page_white_text.png', :size => '16x16', :alt => content_type.display_name.localize, :title => content_type.display_name.localize)
    when 'picture'
      image_tag('icons/picture.png', :size => '16x16', :alt => content_type.display_name.localize, :title => content_type.display_name.localize)
    when 'sound'
      image_tag('icons/sound.png', :size => '16x16', :alt => content_type.display_name.localize, :title => content_type.display_name.localize)
    when 'video'
      image_tag('icons/film.png', :size => '16x16', :alt => content_type.display_name.localize, :title => content_type.display_name.localize)
    else
      image_tag('icons/help.png', :size => '16x16', :alt => ('unknown'), :title => 'unknown')
    end
  rescue NoMethodError
    image_tag('icons/help.png', :size => '16x16', :alt => ('unknown'), :title => 'unknown')
  end

  def patron_type_icon(patron_type)
    case patron_type
    when 'Person'
      image_tag('icons/user.png', :size => '16x16', :alt => ('Person'), :title => ('Person'))
    when 'CorporateBody'
      image_tag('icons/group.png', :size => '16x16', :alt => ('CorporateBody'), :title => ('CorporateBody'))
    else
      image_tag('icons/help.png', :size => '16x16', :alt => ('unknown'), :title => ('unknown'))
    end
  end

  def link_to_tag(tag)
    link_to tag, manifestations_path(:tag => tag.name)
  end

  def render_tag_cloud(tags, options = {})
    return nil if tags.nil?
    # TODO: add options to specify different limits and sorts
    #tags = Tag.all(:limit => 100, :order => 'taggings_count DESC').sort_by(&:name)

    # TODO: add option to specify which classes you want and overide this if you want?
    classes = %w(popular v-popular vv-popular vvv-popular vvvv-popular)

    max, min = 0, 0
    tags.each do |tag|
      #if options[:max] or options[:min]
      #  max = options[:max].to_i
      #  min = options[:min].to_i
      #end
      max = tag.taggings.size if tag.taggings.size > max
      min = tag.taggings.size if tag.taggings.size < min
    end
    divisor = ((max - min).div(classes.size)) + 1

    html =    %(<div class="hTagcloud">\n)
    html <<   %(  <ul class="popularity">\n)
    tags.each do |tag|
      html << %(  <li>)
      html << link_to(tag.name, manifestations_path(:tag => tag.name), :class => classes[(tag.taggings.size - min).div(divisor)])
      html << %(  </li>\n) # FIXME: IEのために文末の空白を入れている
    end
    html <<   %(  </ul>\n)
    html <<   %(</div>\n)
    html.html_safe
  end

  def patrons_list(patrons = [], options = {})
    return nil if patrons.blank?
    patrons_list = []
    has_extra_patron = false
    patrons.each do |patron|
      unless Patron.exclude_patrons.include?(patron.full_name)
        if options[:nolink]
          patrons_list << patron.full_name
        else
          patrons_list << link_to(patron.full_name, patron, options)
        end
      else
        has_extra_patron = true
      end
    end
    patrons_list << I18n.t('page.et_al') if has_extra_patron
#    if options[:nolink]
#      patrons_list = patrons.map{|patron| patron.full_name}
#    else
#      #patrons_list = patrons.map{|patron| link_to(patron.full_name, patron, options)}
#    end
    patrons_list.join(" ").html_safe
  end

  def patrons_short_list(patrons = [], options = {})
    return nil if patrons.blank?
    patrons_list = []
    patrons.each_with_index do |patron, i|
      if i < 3
        if options[:nolink]
          patrons_list << patron.full_name
        else
          patrons_list << link_to(patron.full_name, patron, options)
        end
      end
    end
    patrons_list << '...' if patrons.size > 3 
    patrons_list.join(" ").html_safe
  end

  def book_jacket(manifestation)
    if manifestation.picture_files.exists?
      link = ''
      manifestation.picture_files.each_with_index do |picture_file, i|
        if i == 0
          link += link_to(show_image(picture_file, :size => :thumb), picture_file_path(picture_file, :format => picture_file.extname), :rel => "manifestation_#{manifestation.id}")
        else
          link += '<span style="display: none">' + link_to(show_image(picture_file, :size => :thumb), picture_file_path(picture_file, :format => picture_file.extname), :rel => "manifestation_#{manifestation.id}") + '</span>'
        end
      end
      return link.html_safe
    else
      link = book_jacket_tag(manifestation)
      unless link
        link = screenshot_tag(manifestation)
      end
    end

    unless link
      link = link_to image_tag('unknown_resource.png', :width => '100', :height => '100', :alt => '*', :itemprop => 'image'), manifestation
    end
    link
  #rescue NoMethodError
  #  nil
  end

  def database_adapter
    case ActiveRecord::Base.configurations["#{Rails.env}"]['adapter']
    when 'postgresql'
      link_to 'PostgreSQL', 'http://www.postgresql.org/'
    when 'jdbcpostgresql'
      link_to 'PostgreSQL', 'http://www.postgresql.org/'
    when 'mysql'
      link_to 'MySQL', 'http://www.mysql.org/'
    when 'jdbcmysql'
      link_to 'MySQL', 'http://www.mysql.org/'
    when 'sqlite3'
      link_to 'SQLite', 'http://www.sqlite.org/'
    when 'jdbcsqlite3'
      link_to 'SQLite', 'http://www.sqlite.org/'
    end
  end

  def title_action_name
    case controller.action_name
    when 'index'
      t('title.index')
    when 'show'
      t('title.show')
    when 'new'
      t('title.new')
    when 'edit'
      t('title.edit')
    end
  end

  def link_to_wikipedia(string)
    link_to "Wikipedia", "http://#{I18n.locale}.wikipedia.org/wiki/#{URI.escape(string)}"
  end

  def locale_display_name(locale)
    Language.where(:iso_639_1 => locale).first.display_name
  end

  def locale_native_name(locale)
    Language.where(:iso_639_1 => locale).first.native_name
  end

  def move_position(object)
    render :partial => 'page/position', :locals => {:object => object}
  end

  def localized_state(state)
    case state
    when 'pending'
      t('state.pending')
    when 'canceled'
      t('state.canceled')
    when 'started'
      t('state.started')
    when 'failed'
      t('state.failed')
    when 'completed'
      t('state.completed')
    else
      state
    end
  end

  def localized_boolean(bool)
    case bool.to_s
    when nil
    when "true"
      t('page.boolean.true')
    when "false"
      t('page.boolean.false')
    end
  end

  def current_user_role_name
    current_user.try(:role).try(:name) || 'Guest'
  end

  def title(controller_name)
    string = ''
    unless controller_name == 'page' or controller_name == 'my_accounts' or controller_name == 'opac'
      string << t("activerecord.models.#{controller_name.singularize}") + ' - '
    end
    string << LibraryGroup.system_name + ' - Next-L Enju Trunk'
    string.html_safe
  end

  def back_to_index(options = {})
    if options == nil
      options = {}
    else
      options.reject!{|key, value| value.blank?}
      options.delete(:page) if options[:page].to_i == 1
    end
    unless controller_name == 'test'
      link_to t('page.listing', :model => t("activerecord.models.#{controller_name.singularize}")), url_for(params.merge(:controller => controller_name, :action => :index, :id => nil).merge(options))
    end
  end

  def user_notice(user)
    string = ''
    messages = user.user_notice
    messages.each do |message|
      string << message.gsub("[","").gsub("]", "") + '<br />'
    end
    string.html_safe
  end

  def wareki_dateformat(v)
    ja_wmd(v)
  end

  def dateformat(v)
    return "" if v.nil?
    v.strftime "%Y/%m/%d %H:%M:%S" rescue ""
  end

  def term_check(start_d, end_d)
    return t('page.exstatistics.nil_date') if start_d.blank? or end_d.blank?
    return t('page.exstatistics.invalid_input_date') unless start_d =~ /^((\d+)-?)*\d$/
    return t('page.exstatistics.invalid_input_date') unless end_d =~ /^((\d+)-?)*\d$/
    return t('page.exstatistics.invalid_input_date') if date_format_check(start_d) == nil
    return t('page.exstatistics.invalid_input_date') if date_format_check(end_d) == nil
    return t('page.exstatistics.over_end_date') if end_d.gsub(/\D/, '') < start_d.gsub(/\D/, '')
    nil
  end

  def date_format_check(date)
    date = date.to_s.gsub(/\D/, '')
    return nil if date == nil or date.length != 8
    year = date[0, 4].to_i
    month = date[4, 2].to_i
    day = date[6, 4].to_i
    return nil unless Date.valid_date?(year, month, day)
    date = Time.zone.parse(date)
  end

  def clinet_is_special_ip?
    special_ip_address_list = SystemConfiguration.get("special_ip_address_list").split(",") rescue [""]
    remote_ip = request.env["HTTP_X_FORWARDED_FOR"] || request.remote_ip
    special_ip_address_list.include?(remote_ip)
  end

  ADVANCED_SEARCH_PARAMS = [
    :tag, :title, :creator, :publisher, :isbn, :issn, :item_identifier,
    :pub_date_from, :pub_date_to, :acquired_from, :acquired_to,
    :removed_from, :removed_to, :number_of_pages_at_least,
    :number_of_pages_at_most, :advanced_search,
    :exact_title, :exact_creator, :types, :manifestation_types,
  ]

  ADVANCED_SEARCH_LABEL_IDS = {
    tag: 'page.tag',
    title: 'page.title',
    creator: 'patron.creator',
    publisher: 'patron.publisher',
    isbn: 'activerecord.attributes.manifestation.isbn',
    issn: 'activerecord.attributes.manifestation.issn',
    item_identifier: 'activerecord.attributes.item.item_identifier',
    call_number: 'activerecord.attributes.item.call_number',
    pub_date: 'activerecord.attributes.manifestation.date_of_publication',
    acquired: 'activerecord.attributes.item.acquired_at',
    removed: 'activerecord.attributes.item.removed_at',
    number_of_pages: 'page.number_of_pages',
    exact_title: 'page.exact_title',
    exact_creator: 'page.exact_creator',
    query: 'page.search_term',
    manifestation_types: 'activerecord.models.manifestation_type',
  }

  def advanced_search_label(key)
    I18n.t(ADVANCED_SEARCH_LABEL_IDS[key])
  end

  def link_to_advanced_search(link_title = nil)
    link_title ||= t('page.advanced_search')
    url_params = params.dup

    [:controller, :commit, :utf8].each {|k| url_params.delete(k) }
    link_to link_title, page_advanced_search_path(url_params)
  end

  def link_to_normal_search(link_title = nil)
    return '' if ADVANCED_SEARCH_PARAMS.all? {|k| params[k].blank? }

    link_title ||= t('page.normal_search')
    url_params = params.dup
    [:controller, :commit, :utf8].each {|k| url_params.delete(k) }
    ADVANCED_SEARCH_PARAMS.each {|k| url_params.delete(k) }
    link_to link_title, manifestations_path(url_params)
  end

  def hidden_advanced_search_field_tags
    ADVANCED_SEARCH_PARAMS.map do |name|
      hidden_field_tag(name.to_s, params[name])
    end.join('').html_safe
  end

  def advanced_search_condition_summary(opts = {})
    summary_ary = []
    special = {
      title: nil,
      creator: nil,
      pub_date: nil,
      acquired: nil,
      removed: nil,
      number_of_pages: nil,
    }
    range_delimiter = '-'

    ADVANCED_SEARCH_PARAMS.each do |key|
      next if key == :advanced_search
      next unless params[key]

      case key
      when :pub_date_from, :pub_date_to,
          :acquired_from, :acquired_to,
          :removed_from, :removed_to,
          :number_of_pages_at_least, :number_of_pages_at_most
        t = key.to_s.sub(/_(from|to|at_least|at_most)\z/, '').to_sym
        i = ($1 == 'from' || $1 == 'at_least') ? 0 : 2

        if params[key].present? && special[t].nil?
          special[t] = ['', range_delimiter, '']
          summary_ary << [t, special[t]]
        end
        special[t][i] = params[key] if special[t]

      when :title, :creator, :exact_title, :exact_creator
        t = key.to_s.sub(/\A(exact_)?/, '').to_sym
        v = nil
        if $1
          i = 1
          v = "[#{advanced_search_label(key)}]" if params[t].present?
        else
          i = 0
          v = params[key] if params[key].present?
        end

        if v && special[t].nil?
          special[t] = ['', '']
          summary_ary << [t, special[t]]
        end
        special[t][i] = v if special[t]

      when :manifestation_types #資料区分
        display_name_ary = []
        if params[:manifestation_types].present?
          manifestation_types = params[:manifestation_types].class == String ? eval(params[:manifestation_types]) : params[:manifestation_types]
          manifestation_types.each_key do |manifestation_type_id|
            manifestation_type = ManifestationType.find(manifestation_type_id)
            display_name_ary << manifestation_type.display_name if manifestation_type.present?
          end
       end
       summary_ary << [:manifestation_types, display_name_ary.join(", ")] if display_name_ary.present?
        
      else
        summary_ary << [key, params[key]] if params[key].present?
      end
    end

    return '' if summary_ary.blank?

    omission = ''
    if opts[:length] && summary_ary.size > opts[:length]
      summary_ary = summary_ary[0, opts[:length]]
      omission = opts[:omission] if opts[:omission]
    end

    '(' + summary_ary.map do |label_id, data|
      if data.is_a?(Array)
        if data.any?(&:present?)
          data = data.join('')
        else
          data = nil
        end
      else
        data = data.to_s
      end

      "#{advanced_search_label(label_id)}: #{data}"
    end.join(I18n.t('page.advanced_search_summary_delimiter')) + omission + ')'
  end
end
