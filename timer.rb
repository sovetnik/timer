require 'tzinfo'

class Timer
  attr_reader :path, :query

  def self.call(env)
    new(env).response
  end

  def initialize(env)
    @path = env['PATH_INFO']
    @query = env['QUERY_STRING']
  end

  def response
    if path == '/time'
      [200, { 'Content-Type' => 'text/plain' }, [time_response.join("\n")]]
    else
      [404, { 'Content-Type' => 'text/plain' }, [not_found]]
    end
  end

  def time_response
    zones.map { |zone| formatted_time(zone) }
  end

  def not_found
    'Not found. Try /time?Moscow'
  end

  def formatted_time(zone)
    "#{time(zone).friendly_identifier(true)}: #{time(zone).now.strftime('%Y-%m-%d %H:%M:%S')}"
  end

  def time(zone)
    TZInfo::Timezone.get(zone)
  end

  def pattern
    Regexp.new(query.scan(/([a-zA-Z]+)/).join('|')).freeze
  end

  def zones
    zones_collection = ['UTC']
    return zones_collection if query.empty?
    TZInfo::Timezone.all_identifiers.map { |i| zones_collection << i if i.scan(pattern).any? }
    zones_collection
  end
end
