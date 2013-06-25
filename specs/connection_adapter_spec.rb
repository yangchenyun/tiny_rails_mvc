require_relative 'spec_helper'
require 'sqlite_adapter'

describe SQLiteAdapter do
  describe "#find" do
    it 'returns the record as a hash-like data' do
      result = subject.find('users', 1)
      result['id'].should == 1
      result['name'].should == 'Rock'
    end
  end

  describe '#find_all' do
    it 'returns all records in the db' do
      result = subject.find_all('users')
      result.count.should == 6

      record = result.first
      record['id'].should == 1
      record['name'].should == 'Rock'
    end
  end
end
