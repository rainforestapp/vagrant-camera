require 'tmpdir'
require 'fileutils'

module Vagrant
  module Camera
    class Command < Vagrant.plugin("2", :command)

      def execute
        @options = {}
        @screenshots = []

        opts = OptionParser.new do |o|
          o.banner = "Usage: vagrant camera [vm-name] [options] [-h]"

          if open?
            o.on("-o", "--open", "Open generated image after capture") do |c|
              @options[:open] = true
            end
          end

          o.on("-s PATH", "--save", "Save images to a specific directory.") do |c|
            @options[:save_location] = c
          end
        end

        @argv = parse_options(opts)
        return if !@argv

        capture_screens
      end

      private

      def open?
        !%x{which open}.chomp.to_s.empty?
      end

      def capture_screens
        with_target_vms(@argv[0]) do |vm|

          unless vm.provider.to_s.include?("VirtualBox")
            @env.ui.send :error, "Cannot capture screenshot, we can only capture screenshots on virtualbox instances."
            return
          end

          if vm.state.id != :running
            @env.ui.send :warn, "Skipping #{vm.name} because it's not running."
          else
            @env.ui.send :info, "Capturing screenshot of #{vm.name}"

            filename = File.join(Dir.tmpdir, "screenshot_#{vm.name}_#{Time.now.to_i}.png")

            vm.provider.driver.execute_command [
              "controlvm",
              vm.provider.driver.uuid,
              "screenshotpng",
              filename
            ]

            @env.ui.send :success, "Screenshot saved at #{filename}"
            @screenshots << filename

            %x{open #{@screenshots.join(' ')}} if @options[:open]

            unless @options[:save_location].nil?
              @screenshots.each do |file|
                new_file = File.join(@options[:save_location], File.basename(file))

                begin
                  FileUtils.copy(file, new_file)
                  @env.ui.send :success, "#{file} -> #{new_file}"
                rescue => e
                  @env.ui.send(:error, e.message)
                end
              end
            end
          end
        end
      end
    end
  end
end
