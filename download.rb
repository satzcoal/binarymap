require "open-uri"
class Download
  def down(uri, name)
    open(uri) do |fin|
      open("bitmap/#{name}.jpg","wb") do |fout|
        while buf = fin.read(1024) do
          fout.write buf
          STDOUT.flush
        end
      end
    end
  end
end