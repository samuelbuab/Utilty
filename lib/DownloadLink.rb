# encoding: UTF-8
require 'base64'
class DownloadLink
  attr_reader :protocal, :url
  def initialize(str)
    post_initialize(str)
  end
  
  def post_initialize(str)
    tmp = str.split("://")
    @protocal = tmp.first.downcase if tmp.length > 1
    @url = tmp.last
     
    if @protocal != nil and pri_protocals.has_key?(@protocal.to_sym)
      @url = decode64( @url, &pri_protocals[@protocal.to_sym] )
    else
      @url = str
    end
  end
  
  def to_s
    "\n#{ @protocal ? @protocal:"Unknown Protocal" }\t#{url}"
  end
  
  private
  def command_protocals                         # no use
    ["http","https","ftp"]
  end
  
  def pri_protocals    
    {
      :thunder => proc {|str| str["AA".length, str.length-"AA".length-"ZZ".length] },
      :flashget => proc {|str| str["[FLASHGET]".length, str.length-2*("[FLASHGET]".length)] },
      :qqdl => proc {|str| str }
    }
  end
  
  def decode64(str,&block)
    str = Base64.decode64 str
    yield str if block_given?
  end
end

if __FILE__ == $0
  test = DownloadLink.new(gets.chomp)
  puts test
end
