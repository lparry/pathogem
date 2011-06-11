module Pathogem
  class Manifest
    def self.add(gem)
      manifest = read_manifest
      manifest << gem
      write_manifest(manifest)
    end

    def self.remove(gem)
      manifest = read_manifest
      manifest.delete(gem)
      write_manifest(manifest)
    end

    private

    def self.read_manifest
      File.exist?(Pathogem.manifest_file) ? File.read(Pathogem.manifest_file).split("\n") : []
    end

    def self.write_manifest(manifest)
      File.open(Pathogem.manifest_file, 'w') do |f|
        manifest.uniq.sort.each do |line|
          f.write "#{line}\n"
        end
      end
    end
  end
end
