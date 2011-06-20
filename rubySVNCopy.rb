require 'find'

in_path = 'C:/Users/vmendi/Documents/Flash/PlanetWarsServer/SmartFoxServer PRO 1.6.6'
out_path = 'C:/Users/vmendi/Documents/UnusualSVN/PlanetWarsServer/SmartFoxServer PRO 1.6.6'

exclude = ".svn"

unless FileTest.exist?(in_path)
  puts "Input directory doesn't exist"
else
  Find.find(in_path) { |path|
    if FileTest.directory?(path)
      unless path[exclude] == nil
        Find.prune
      else
        path.sub!(in_path, "")
        path.insert(0, out_path)
        # Creamos el directorio destino
        Dir.mkdir path unless FileTest.exist?(path)
        next
      end
    else
      dest_path = path.sub(in_path, "")
      dest_path.insert(0, out_path)
      # Si ya existe, no sobreescribimos
      unless FileTest.exist?(dest_path)
        FileUtils.cp path, dest_path, :preserve => true
      end
    end
  }
end