# -*- encoding: utf-8 -*-
# stub: selenium-webdriver 2.43.0 ruby lib

Gem::Specification.new do |s|
  s.name = "selenium-webdriver".freeze
  s.version = "2.43.0"

  s.required_rubygems_version = Gem::Requirement.new("> 1.3.1".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Jari Bakken".freeze]
  s.date = "2024-03-19"
  s.description = "WebDriver is a tool for writing automated tests of websites. It aims to mimic the behaviour of a real user, and as such interacts with the HTML of the application.".freeze
  s.email = "jari.bakken@gmail.com".freeze
  s.files = ["CHANGES".freeze, "COPYING".freeze, "Gemfile".freeze, "README.md".freeze, "lib/selenium".freeze, "lib/selenium-client.rb".freeze, "lib/selenium-webdriver.rb".freeze, "lib/selenium/client".freeze, "lib/selenium/client.rb".freeze, "lib/selenium/client/base.rb".freeze, "lib/selenium/client/driver.rb".freeze, "lib/selenium/client/errors.rb".freeze, "lib/selenium/client/extensions.rb".freeze, "lib/selenium/client/idiomatic.rb".freeze, "lib/selenium/client/javascript_expression_builder.rb".freeze, "lib/selenium/client/javascript_frameworks".freeze, "lib/selenium/client/javascript_frameworks/jquery.rb".freeze, "lib/selenium/client/javascript_frameworks/prototype.rb".freeze, "lib/selenium/client/legacy_driver.rb".freeze, "lib/selenium/client/protocol.rb".freeze, "lib/selenium/client/selenium_helper.rb".freeze, "lib/selenium/rake".freeze, "lib/selenium/rake/server_task.rb".freeze, "lib/selenium/server.rb".freeze, "lib/selenium/webdriver".freeze, "lib/selenium/webdriver.rb".freeze, "lib/selenium/webdriver/android".freeze, "lib/selenium/webdriver/android.rb".freeze, "lib/selenium/webdriver/android/bridge.rb".freeze, "lib/selenium/webdriver/chrome".freeze, "lib/selenium/webdriver/chrome.rb".freeze, "lib/selenium/webdriver/chrome/bridge.rb".freeze, "lib/selenium/webdriver/chrome/profile.rb".freeze, "lib/selenium/webdriver/chrome/service.rb".freeze, "lib/selenium/webdriver/common".freeze, "lib/selenium/webdriver/common.rb".freeze, "lib/selenium/webdriver/common/action_builder.rb".freeze, "lib/selenium/webdriver/common/alert.rb".freeze, "lib/selenium/webdriver/common/bridge_helper.rb".freeze, "lib/selenium/webdriver/common/core_ext".freeze, "lib/selenium/webdriver/common/core_ext/base64.rb".freeze, "lib/selenium/webdriver/common/core_ext/dir.rb".freeze, "lib/selenium/webdriver/common/core_ext/string.rb".freeze, "lib/selenium/webdriver/common/driver.rb".freeze, "lib/selenium/webdriver/common/driver_extensions".freeze, "lib/selenium/webdriver/common/driver_extensions/has_browser_connection.rb".freeze, "lib/selenium/webdriver/common/driver_extensions/has_input_devices.rb".freeze, "lib/selenium/webdriver/common/driver_extensions/has_location.rb".freeze, "lib/selenium/webdriver/common/driver_extensions/has_remote_status.rb".freeze, "lib/selenium/webdriver/common/driver_extensions/has_session_id.rb".freeze, "lib/selenium/webdriver/common/driver_extensions/has_touch_screen.rb".freeze, "lib/selenium/webdriver/common/driver_extensions/has_web_storage.rb".freeze, "lib/selenium/webdriver/common/driver_extensions/rotatable.rb".freeze, "lib/selenium/webdriver/common/driver_extensions/takes_screenshot.rb".freeze, "lib/selenium/webdriver/common/driver_extensions/uploads_files.rb".freeze, "lib/selenium/webdriver/common/element.rb".freeze, "lib/selenium/webdriver/common/error.rb".freeze, "lib/selenium/webdriver/common/file_reaper.rb".freeze, "lib/selenium/webdriver/common/html5".freeze, "lib/selenium/webdriver/common/html5/local_storage.rb".freeze, "lib/selenium/webdriver/common/html5/location.rb".freeze, "lib/selenium/webdriver/common/html5/session_storage.rb".freeze, "lib/selenium/webdriver/common/html5/shared_web_storage.rb".freeze, "lib/selenium/webdriver/common/json_helper.rb".freeze, "lib/selenium/webdriver/common/keyboard.rb".freeze, "lib/selenium/webdriver/common/keys.rb".freeze, "lib/selenium/webdriver/common/log_entry.rb".freeze, "lib/selenium/webdriver/common/logs.rb".freeze, "lib/selenium/webdriver/common/mouse.rb".freeze, "lib/selenium/webdriver/common/navigation.rb".freeze, "lib/selenium/webdriver/common/options.rb".freeze, "lib/selenium/webdriver/common/platform.rb".freeze, "lib/selenium/webdriver/common/port_prober.rb".freeze, "lib/selenium/webdriver/common/profile_helper.rb".freeze, "lib/selenium/webdriver/common/proxy.rb".freeze, "lib/selenium/webdriver/common/search_context.rb".freeze, "lib/selenium/webdriver/common/socket_poller.rb".freeze, "lib/selenium/webdriver/common/target_locator.rb".freeze, "lib/selenium/webdriver/common/timeouts.rb".freeze, "lib/selenium/webdriver/common/touch_action_builder.rb".freeze, "lib/selenium/webdriver/common/touch_screen.rb".freeze, "lib/selenium/webdriver/common/wait.rb".freeze, "lib/selenium/webdriver/common/window.rb".freeze, "lib/selenium/webdriver/common/zipper.rb".freeze, "lib/selenium/webdriver/firefox".freeze, "lib/selenium/webdriver/firefox.rb".freeze, "lib/selenium/webdriver/firefox/binary.rb".freeze, "lib/selenium/webdriver/firefox/bridge.rb".freeze, "lib/selenium/webdriver/firefox/extension".freeze, "lib/selenium/webdriver/firefox/extension.rb".freeze, "lib/selenium/webdriver/firefox/extension/prefs.json".freeze, "lib/selenium/webdriver/firefox/extension/webdriver.xpi".freeze, "lib/selenium/webdriver/firefox/launcher.rb".freeze, "lib/selenium/webdriver/firefox/native".freeze, "lib/selenium/webdriver/firefox/native/linux".freeze, "lib/selenium/webdriver/firefox/native/linux/amd64".freeze, "lib/selenium/webdriver/firefox/native/linux/amd64/x_ignore_nofocus.so".freeze, "lib/selenium/webdriver/firefox/native/linux/x86".freeze, "lib/selenium/webdriver/firefox/native/linux/x86/x_ignore_nofocus.so".freeze, "lib/selenium/webdriver/firefox/profile.rb".freeze, "lib/selenium/webdriver/firefox/profiles_ini.rb".freeze, "lib/selenium/webdriver/firefox/socket_lock.rb".freeze, "lib/selenium/webdriver/firefox/util.rb".freeze, "lib/selenium/webdriver/ie".freeze, "lib/selenium/webdriver/ie.rb".freeze, "lib/selenium/webdriver/ie/bridge.rb".freeze, "lib/selenium/webdriver/ie/server.rb".freeze, "lib/selenium/webdriver/iphone".freeze, "lib/selenium/webdriver/iphone.rb".freeze, "lib/selenium/webdriver/iphone/bridge.rb".freeze, "lib/selenium/webdriver/opera".freeze, "lib/selenium/webdriver/opera.rb".freeze, "lib/selenium/webdriver/opera/bridge.rb".freeze, "lib/selenium/webdriver/opera/service.rb".freeze, "lib/selenium/webdriver/phantomjs".freeze, "lib/selenium/webdriver/phantomjs.rb".freeze, "lib/selenium/webdriver/phantomjs/bridge.rb".freeze, "lib/selenium/webdriver/phantomjs/service.rb".freeze, "lib/selenium/webdriver/remote".freeze, "lib/selenium/webdriver/remote.rb".freeze, "lib/selenium/webdriver/remote/bridge.rb".freeze, "lib/selenium/webdriver/remote/capabilities.rb".freeze, "lib/selenium/webdriver/remote/commands.rb".freeze, "lib/selenium/webdriver/remote/http".freeze, "lib/selenium/webdriver/remote/http/common.rb".freeze, "lib/selenium/webdriver/remote/http/curb.rb".freeze, "lib/selenium/webdriver/remote/http/default.rb".freeze, "lib/selenium/webdriver/remote/http/persistent.rb".freeze, "lib/selenium/webdriver/remote/response.rb".freeze, "lib/selenium/webdriver/remote/server_error.rb".freeze, "lib/selenium/webdriver/safari".freeze, "lib/selenium/webdriver/safari.rb".freeze, "lib/selenium/webdriver/safari/bridge.rb".freeze, "lib/selenium/webdriver/safari/browser.rb".freeze, "lib/selenium/webdriver/safari/extensions.rb".freeze, "lib/selenium/webdriver/safari/options.rb".freeze, "lib/selenium/webdriver/safari/resources".freeze, "lib/selenium/webdriver/safari/resources/SafariDriver.safariextz".freeze, "lib/selenium/webdriver/safari/resources/client.js".freeze, "lib/selenium/webdriver/safari/server.rb".freeze, "lib/selenium/webdriver/support".freeze, "lib/selenium/webdriver/support.rb".freeze, "lib/selenium/webdriver/support/abstract_event_listener.rb".freeze, "lib/selenium/webdriver/support/block_event_listener.rb".freeze, "lib/selenium/webdriver/support/color.rb".freeze, "lib/selenium/webdriver/support/event_firing_bridge.rb".freeze, "lib/selenium/webdriver/support/select.rb".freeze, "selenium-webdriver.gemspec".freeze]
  s.homepage = "http://selenium.googlecode.com".freeze
  s.licenses = ["Apache".freeze]
  s.rubygems_version = "3.3.26".freeze
  s.summary = "The next generation developer focused tool for automated testing of webapps".freeze

  s.installed_by_version = "3.3.26" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<multi_json>.freeze, ["~> 1.0"])
    s.add_runtime_dependency(%q<rubyzip>.freeze, ["~> 1.0"])
    s.add_runtime_dependency(%q<childprocess>.freeze, ["~> 0.5"])
    s.add_runtime_dependency(%q<websocket>.freeze, ["~> 1.0"])
    s.add_development_dependency(%q<rspec>.freeze, ["~> 2.99.0"])
    s.add_development_dependency(%q<rack>.freeze, ["~> 1.0"])
    s.add_development_dependency(%q<ci_reporter>.freeze, ["~> 1.6", ">= 1.6.2"])
    s.add_development_dependency(%q<webmock>.freeze, ["~> 1.7", ">= 1.7.5"])
  else
    s.add_dependency(%q<multi_json>.freeze, ["~> 1.0"])
    s.add_dependency(%q<rubyzip>.freeze, ["~> 1.0"])
    s.add_dependency(%q<childprocess>.freeze, ["~> 0.5"])
    s.add_dependency(%q<websocket>.freeze, ["~> 1.0"])
    s.add_dependency(%q<rspec>.freeze, ["~> 2.99.0"])
    s.add_dependency(%q<rack>.freeze, ["~> 1.0"])
    s.add_dependency(%q<ci_reporter>.freeze, ["~> 1.6", ">= 1.6.2"])
    s.add_dependency(%q<webmock>.freeze, ["~> 1.7", ">= 1.7.5"])
  end
end
