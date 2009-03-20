require 'spec/spec_helper'

describe ActionQuery do

  before(:each) do
    generate_models
    generate_records
  end

  it "finds all of a given class" do
    ActionQuery['article'].should == Article.all
    ActionQuery['comment'].should == Comment.all
  end

  it "finds by attribute" do
    ActionQuery['article[name=published]'].should == [@published_article]
  end

  it "finds by multiple attributes" do
    ActionQuery['comment[name=ok][body=Pretty good]'].should == [@published_comment]
  end

  it "works with quoted strings" do
    ActionQuery['comment[name=ok][body="Pretty good"]'].should == [@published_comment]
    ActionQuery["comment[name=ok][body='Pretty good']"].should == [@published_comment]
  end

  it "finds first" do
    ActionQuery['article:first'].should == Article.first
  end
end
