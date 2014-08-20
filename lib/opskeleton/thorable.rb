module Opsk 
  module Thorable
    def self.included klass
	def klass.source_root
	  # during dev time
	  if(File.dirname(__FILE__) == './bin')
	    File.dirname('.')
	  else 
	    "#{File.dirname(__FILE__)}/../../"
	  end
	end
    end

    def meta 
	OpenStruct.new(YAML.load_file('opsk.yaml'))
    end

    def type_of
	return :puppet if meta.includes.include?('Puppetfile')
	return :chef if meta.includes.include?('Cheffile')
	raise Exception.new('no matching provisoner type found, make sure to include Cheffile or Pupppetfile in opsk.yaml')
    end

    def name 
	"#{meta.name}-sandbox"
    end

    def artifact
	"#{name}-#{meta.version}"
    end

    def artifact_path
	"pkg/#{name}-#{meta.version}"
    end


  end
end
