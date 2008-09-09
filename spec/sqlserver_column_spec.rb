require File.dirname(__FILE__) + '/spec_helper'
describe 'SQLServerColumn' do
  before do
    @company = Company.new
  end
   
  describe "removing date and time casting" do
    it "should not call adapters cast_to_time method" do      
      column = @company.column_for_attribute('created_at')
      column.should_not_receive(:cast_to_datetime)
      column.type_cast('2000-01-01')
    end  
  end
end
