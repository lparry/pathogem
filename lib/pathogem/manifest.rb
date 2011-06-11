module Pathogem
  class Manifest
    def self.add(gem)
      manifest = read_manifest
      manifest << gem
      File.open(Pathogem.manifest_file, 'w') do |f|
        manifest.uniq.each do |line|
          f.write "#{line}\n"
        end
      end
    end

    def self.remove(gem)
    end

    def self.read_manifest
      File.exist?(Pathogem.manifest_file) ? File.read(Pathogem.manifest_file).split("\n") : []
    end
  end
end
