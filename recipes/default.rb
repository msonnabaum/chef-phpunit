# 
# Author:: Mark Sonnabaum <mark.sonnabaum@acquia.com>
# Contributor:: Patrick Connolly <patrick@myplanetdigital.com>
#
# Cookbook Name:: phpunit
# Recipe:: default
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

include_recipe "php"

# phpunit/PHPUnit depends on symfony/YAML
channels = %w{pear.phpunit.de pear.symfony-project.com}
channels.each do |chan|
  php_pear_channel chan do
    action [:discover, :update]
  end
end

php_pear "PEAR-phpunit" do
  version "1.9.0"
  action :upgrade
end

php_pear "File_Iterator" do
  channel "phpunit"
	action :install
end

php_pear "Text_Template" do
  channel "phpunit"
  version "1.1.3"
  action :install
end

php_pear "PHPUnit" do
  channel "phpunit"
  version node['phpunit']['version']
  action :install
end
