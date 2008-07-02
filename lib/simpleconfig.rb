require 'erb'
require 'yaml'

class SimpleConfig < Hash
  
  VERSION='0.0.3'
  AUTHORS=["Brendan Baldwin"]
  EMAIL=["brendan@usergenic.com"]
  DESCRIPTION=%q{This is a really simple system for getting configuration data into your app.  See the wiki at http://github.com/brendan/simpleconfig/wikis for usage.}
  FOLDER=File.expand_path(File.join(File.dirname(__FILE__),'..'))
  MANIFEST=Dir.glob(File.join(FOLDER,'**','*')).map{|path|path[FOLDER.size+1..-1]}
  HOMEPAGE="http://github.com/brendan/simpleconfig/wikis"
  
  def [](key)
    super key.to_s
  end
  
  def []=(key,value)
    value = self.class.new.replace(value) if value.is_a?(Hash) and !value.is_a?(self.class)
    super key.to_s, value
  end

  def fetch(key, default=nil, &block)
    super(key.to_s, default, &block)
  end
  
  def freeze
    values.each do |value|
      value.freeze if value.respond_to?(:freeze)
    end
    super
  end
  
  def has_key?(key)
    super key.to_s
  end
  
  def key?(key)
    super key.to_s
  end
  
  def merge!(other)
    other.each do |key, value|
      if self[key].is_a?(Hash) and value.is_a?(Hash)
        self[key].merge!(value)
      else
        self[key] = value
      end
    end
  end
  
  def replace(other)
    clear
    other.each do |key, value|
      self[key] = value
    end
    self
  end
  
  protected
  
  def methodize_keys_and_freeze
    keys.each do |key|
      value = send(key)
      value.methodize_keys_and_freeze if value.is_a?(Hash)
    end
    freeze
    self
  end
  
  private

  def initialize(*folders)
    @folders = folders unless folders.empty?
  end

  def load_and_merge(paths)
    merged_data = nil
    paths.each do |path|
      if File.exists?(path)
        data = YAML.load(ERB.new(File.read(path)).result)
        data = self.class.new.replace(data) if data.is_a?(Hash)
        if merged_data.is_a?(Hash)
          merged_data.merge!(data)
        else
          merged_data = data
        end
      end
    end
    merged_data.methodize_keys_and_freeze if merged_data.is_a?(Hash)
    merged_data
  end

  def method_missing(method_id, *arguments, &block)
    if defined?(@folders)
      data = load_and_merge(@folders.reverse.map {|f| File.join(f,"#{method_id}.yml")})
      self[method_id] = data unless data == nil
    end
    return super unless key?(method_id)
    class << self; self; end.send(:define_method, method_id) { self[method_id] }
    send(method_id)
  end

end