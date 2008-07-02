require File.join(File.dirname(__FILE__), 'spec_helper')

describe "SimpleConfig" do
  
  def fixture_folders
    %w{folder1 folder2}.map{|f|File.join(File.dirname(__FILE__),'fixtures',f)}
  end
  
  describe ".new" do

    it "creates a new SimpleConfig hash and sets the @folders instance_variable to the list of arguments provided." do
      config = SimpleConfig.new('x','y','z')
      config.instance_variable_get('@folders').should == ['x','y','z']
    end

  end
  
  describe "#method_missing" do

    it "when a key matching the method_id string is present, defines a singleton_method named for the key to return the value and calls it." do
      config = SimpleConfig.new
      config['some_key']=1
      config.should be_key('some_key')
      config.methods.should_not include('some_key')
      config.some_key.should == 1
      config.methods.should include('some_key')
      config.some_key.should == 1
    end

    it "delegates to method_missing super if no matching key is found" do
      config = SimpleConfig.new
      config[:this_method_does_exist] = "good_for_you"
      proc{config.this_method_does_not_exist}.should raise_error(NoMethodError)
      proc{config.this_method_does_exist}.should_not raise_error(NoMethodError)
    end

  end
  
  describe "when all is said and done" do
    
    it "performs a load_and_merge for all files named data.yml in specified folders, giving preference to first" do
      config = SimpleConfig.new(*fixture_folders)
      config.data.some_key.should == 'some_value'
      config.data.some_other_key.should == 'some_other_value'
      config.data.some_key_with_hash_value.some_subkey.should == 'some_subvalue'
      config.data.some_key_with_hash_value.some_other_subkey.should == 'some_other_subvalue'
      config.should == {
        'data' => {
          'some_key' => 'some_value',
          'some_other_key' => 'some_other_value',
          'some_key_with_hash_value' => {
            'some_subkey' => 'some_subvalue',
            'some_other_subkey' => 'some_other_subvalue' }}}
    end

    it "runs file content through ERB before parsing with YAML" do
      config = SimpleConfig.new(*fixture_folders)
      config.erbified.a_dynamic_key.should == 'some_dynamic_content'
      config.should == {'erbified' => {'a_dynamic_key' => 'some_dynamic_content'}}
    end

  end
  
end
