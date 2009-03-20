require 'rubygems'
require 'spec'
require 'acts_as_fu'
require File.join(File.dirname(__FILE__), *%w[.. lib action_query])

def generate_models
  build_model(:articles) do
    string :name
    boolean :published
    timestamps
    
    has_many :comments
  end
  
  build_model(:comments) do
    integer :article_id
    string :name
    text :body
    timestamps
    
    belongs_to :article
  end
end

def generate_records
  @published_article = Article.create!(:name => 'published', :published => true)
  @unpublished_article = Article.create!(:name => 'not published', :published => false)
  
  @published_comment = @published_article.comments.create! \
    :body => 'Pretty good',
    :name => 'ok'
  @other_published_comment = @published_article.comments.create! \
    :body => 'I think so',
    :name => 'ok'
  @unpublished_comment = @unpublished_article.comments.create! :body => 'word'
end