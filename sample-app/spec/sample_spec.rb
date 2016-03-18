require 'spec_helper'

require "docker"
require "serverspec"

describe "Dockerfile" do
	  before(:all) do
		 @image = Docker::Image.build_from_dir('/usr/src/app/spec/')

		 set :os, family: :ubuntu
		 set :backend, :docker
		 set :docker_image, @image.id
	   end

	   describe file('/usr/share/nginx/html/index.html') do
		 it { should be_file }
	   end
	   describe package('nginx') do
		 it { should be_installed }
	   end
	   describe file('/usr/share/nginx/html/index.html') do
		     its(:content) { should match /Hello World/ }
	   end
end
