require_relative 'counter_helper'

class Counter
  include CounterHelper

  attr_reader :file
  attr_accessor :page_views

  def initialize(file)
    @file = file
    @page_views = {

    }
  end

  def run
    helper = CounterHelper
    file.each_line do |line|
      page, ip = line.split(' ')
      if helper.new_page?(page_views, page)
        helper.add_new_page(page_views, page, ip)
      else
        helper.add_page(page_views, page)
        helper.add_unique_ip(page_views, page, ip) if helper.unique_ip?(page_views, page, ip)
      end
    end
  end

  def show_total_views
    arr = []
    page_views.sort_by { |_k, v| -v[:total_views] }.each do |k, v|
      arr << "#{k} #{v[:total_views]} visits"
    end
    arr
  end

  def show_unique_views
    arr = []
    page_views.sort_by { |_k, v| -v[:unique_views] }.each do |k, v|
      arr << "#{k} #{v[:unique_views]} unique views"
    end
    arr
  end
end
