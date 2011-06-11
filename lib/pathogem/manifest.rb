module Pathogem
  class Manifest
    def self.add(gem)
      File.open(Pathogem.manifest_file, 'a') do |f|
        f.write "\n#{gem}"
      end
    end

    def self.remove(gem)
    end
  end
end
