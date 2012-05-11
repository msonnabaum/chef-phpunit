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

php_pear_channel "pear.phpunit.de" do
  action [:discover, :update]
end

php_pear "PEAR" do
  cur_version = `pear -V| head -1| awk -F': ' '{print $2}'`
  action :upgrade
  # This feels super ghetto. Open to improvements.
  not_if { Gem::Version.new(cur_version) > Gem::Version.new('1.9.0') }
end

php_pear "PHPUnit" do
  channel "phpunit"
  version "3.6.7"
  action :install
end
