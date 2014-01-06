require "active_support/core_ext/string/inflections"

module EmberDev
  module Generators
    class Project < Thor::Group
      include Thor::Actions
      attr_accessor :project_name
      # Define arguments and options
      argument :project_path,     type: :string

      class_option :author,       type: :string, aliases: '-U', default: `whoami`
      class_option :organization, type: :string, aliases: '-O', default: `whoami`
      class_option :pretty_name,  type: :strting, aliases: '-N', default: false
      
      
      
      source_root File.dirname(__FILE__)

      def source_root
        @source_root ||= Pathname.new(Project.source_root)
      end
      
      def template_path(path='')
        File.join("templates", path)
      end
      
      def set_defaults
        self.destination_root = File.expand_path(project_root, destination_root)
        self.project_name = File.basename(self.destination_root)
        
      end
      
      def create_root        
        empty_directory '.'
        FileUtils.cd(destination_root)
      end
      
      def create_dirs
        directory template_path('generators')
        directory template_path('packages')
      end


      def pretty_project_name
        options.pretty_name || self.project_name.humanize
      end
    end
  end
end