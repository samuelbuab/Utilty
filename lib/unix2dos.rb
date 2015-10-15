#ruby -d unix2dos.rb

def input_filename()
  trap (:INT) { exit() }
  
  filename = gets.chomp
  loop{
    if File.exist?(filename)
      if File.directory?(filename)
        puts "no,it is a directory"
      else
        break
      end
    else
      puts "sorry,it is not a file"
    end
  
    print "which file?"
    filename = gets.chomp
  }
  if $DEBUG
    puts "filename = #{filename}"
  end
  
  filename
end

def transform(infilename,outfilename)
  infile = File.new(infilename,"rb")
  outfile = File.new(outfilename,"wb")
  count = 0

  #puts "[*] Begin ..."

  while !infile.eof do
    _tmp = infile.getc
    if _tmp == "\n" 
        outfile.putc "\r"   
        count = count + 1 
    end

    outfile.putc _tmp
    count = count + 1
  end

  infile.close
  outfile.close
  count
end

def unix2dos
  puts "Which file you want to transform,you can drag it to this command window?"
  filename = input_filename
  filesize = File.size filename
  puts "[*] filesize is #{filesize.to_s} byte(s)"

  outfilename = filename
  loop do
    arrfile = File.split(outfilename)
    if arrfile[0][-1,1] != "\\"
      arrfile[0] = arrfile[0] + "\\"  
    end  
    outfilename = arrfile[0] + "unix2dos_" + arrfile[1]
    break unless File.exist?(outfilename)
  end
  
  count = transform(filename,outfilename)
  puts "[*] Totally transform #{count} byte(s)"
  puts "[+] Complete ."
  #puts `pause`
end

unix2dos








