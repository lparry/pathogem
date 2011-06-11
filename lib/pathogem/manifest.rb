module Pathogem
  class Manifest
    def self.add(plugin)
      manifest = all
      manifest << plugin
      write_manifest(manifest)
    end

    def self.installed?(plugin)
      all.include? plugin
    end

    def self.remove(plugin)
      manifest = all
      manifest.delete(plugin)
      write_manifest(manifest)
    end

    def self.all
      File.exist?(Pathogem.manifest_file) ? File.read(Pathogem.manifest_file).split("\n") : []
    end

    private

    def self.write_manifest(manifest)
      File.open(Pathogem.manifest_file, 'w') do |f|
        manifest.uniq.sort.each do |line|
          f.write "#{line}\n"
        end
      end
    end
  end
end
