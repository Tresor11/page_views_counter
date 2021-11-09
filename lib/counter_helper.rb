module CounterHelper
  def self.add_new_page(page_set, page, ip)
    page_set[page] = {
      "total_views": 1,
      "unique_views": 1,
      "visits_ips": {
        ip.to_sym => 1
      }
    }
  end

  def self.add_page(page_set, page)
    page_set[page][:total_views] += 1
  end

  def self.unique_ip?(page_set, page, ip)
    page_set[page][:visits_ips][ip.to_sym].nil?
  end

  def self.add_unique_ip(page_set, page, ip)
    page_set[page][:unique_views] += 1
    page_set[page][:visits_ips][ip.to_sym] = 1
  end

  def self.new_page?(page_set, page)
    page_set[page].nil?
  end
end
