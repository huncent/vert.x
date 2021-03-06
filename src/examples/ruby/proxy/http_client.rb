# Copyright 2011 the original author or authors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

require "vertx"
include Vertx

@client = HttpClient.new
@client.port = 8080
@client.host = "localhost"
req = @client.put("/someurl") do |resp|
  puts "Got response #{resp.status_code}"
  resp.body_handler { |buffer| puts "Got data #{buffer}" }
end
req.chunked = true
for i in 0..9
  req.write_str("client-data-chunk-#{i}")
end
req.end

def vertx_stop
  @client.close
end