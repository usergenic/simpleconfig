      Gem::Specification.new do |s|
        s.name = %q{simpleconfig}
        s.version = "0.0.3"

        s.specification_version = 2 if s.respond_to? :specification_version=

        s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
        s.authors = ["Brendan Baldwin"]
        s.date = "2008-07-02"
        s.default_executable = nil
        s.description = "This is a really simple system for getting configuration data into your app.  See the wiki at http://github.com/brendan/simpleconfig/wikis for usage."
        s.email = ["brendan@usergenic.com"]
        s.executables = []
        s.extra_rdoc_files = ["History.txt", "Manifest.txt", "README.txt"]
        s.files = ["History.txt", "lib", "lib/simpleconfig.rb", "Manifest.txt", "Rakefile", "README", "simpleconfig.gemspec", "spec", "spec/fixtures", "spec/fixtures/folder1", "spec/fixtures/folder1/data.yml", "spec/fixtures/folder1/erbified.yml", "spec/fixtures/folder1/other_data.yml", "spec/fixtures/folder2", "spec/fixtures/folder2/data.yml", "spec/fixtures/folder2/only_in_folder2.yml", "spec/fixtures/folder2/other_data.yml", "spec/simpleconfig_spec.rb", "spec/spec_helper.rb"]
        s.has_rdoc = true
        s.homepage = "http://github.com/brendan/simpleconfig/wikis"
        s.rdoc_options = ["--main", "README.txt"]
        s.require_paths = ["lib"]
        s.rubygems_version = %q{1.1.1}
        s.summary = "This is a really simple system for getting configuration data into your app.  See the wiki at http://github.com/brendan/simpleconfig/wikis for usage."
      end
