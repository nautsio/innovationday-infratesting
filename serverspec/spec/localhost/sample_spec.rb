require 'spec_helper'

#describe package('httpd'), :if => os[:family] == 'redhat' do
#  it { should be_installed }
#end

#describe package('apache2'), :if => os[:family] == 'ubuntu' do
#  it { should be_installed }
#end

#describe service('httpd'), :if => os[:family] == 'redhat' do
#  it { should be_enabled }
#  it { should be_running }
#end

#describe service('apache2'), :if => os[:family] == 'ubuntu' do
#  it { should be_enabled }
#  it { should be_running }
#end

#describe service('org.apache.httpd'), :if => os[:family] == 'darwin' do
#  it { should be_enabled }
#  it { should be_running }
#end

#describe port(80) do
#  it { should be_listening }
#end
#
require "docker"
require "serverspec"

describe "Dockerfile" do
	  before(:all) do
		 @image = Docker::Image.build_from_dir('/usr/src/app/spec/localhost/')

		 set :os, family: :redhat
		 set :backend, :docker
		 set :docker_image, @image.id
	   end

	   describe file('/etc/centos-release') do
		 it { should be_file }
	   end
	   describe package('redis') do
		 it { should be_installed }
	   end
end
