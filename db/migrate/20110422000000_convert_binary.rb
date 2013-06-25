# -*- coding: binary -*-

# Converts web_pages.body, web_pages.request, web_vulns.proof and web_vulns.proof to binary.
class ConvertBinary < ActiveRecord::Migration
  # Model to help with updating web_pages.
  class WebPage < ActiveRecord::Base
    #
    # Serializatins
    #

    # @!attribute [rw] headers
    #   Headers from web page.
    #
    #   @return [Hash]
    serialize :headers
  end

  # Model to help with updating web_vulns.
  class WebVuln < ActiveRecord::Base
    #
    # Serializations
    #

    # @!attribute [rw] params
    #   Parameters sent to trigger web vulnerability.
    #
    #   @return [Array<Array(String, String)>]
    serialize :params
  end

  # Filters non-ASCII characters from string.
  #
  # @param str [String, #encoding=] a binary string that may contain non-ASCII characters
  # @return [String] `str` filtered of non-ascii characters.
  def bfilter(str)
    str = str.to_s
    str.encoding = 'binary' if str.respond_to?('encoding=')
    str.gsub(/[\x00\x7f-\xff]/, '')
  end

  # Converts web_pages.body, web_pages.request, web_vulns.proof and web_vulns.proof to text from binary by using
  # {#bfilter}.
  #
  # @return [void]
  def down
    rename_column :web_pages, :body, :body_binary
    rename_column :web_pages, :request, :request_binary
    rename_column :web_vulns, :request, :request_binary
    rename_column :web_vulns, :proof, :proof_binary

    add_column :web_pages, :body, :text
    add_column :web_pages, :request, :text
    add_column :web_vulns, :request, :text
    add_column :web_vulns, :proof, :text

    WebPage.find(:all).each { |r| r.body = bfilter(r.body_binary); r.save! }
    WebPage.find(:all).each { |r| r.request = bfilter(r.request_binary); r.save! }
    WebVuln.find(:all).each { |r| r.proof = bfilter(r.proof_binary); r.save! }
    WebVuln.find(:all).each { |r| r.request = bfilter(r.request_binary); r.save! }

    remove_column :web_pages, :body_binary
    remove_column :web_pages, :request_binary
    remove_column :web_vulns, :request_binary
    remove_column :web_vulns, :proof_binary

    WebPage.connection.schema_cache.clear!
    WebPage.reset_column_information
    WebVuln.connection.schema_cache.clear!
    WebVuln.reset_column_information
  end

  # Converts web_pages.body, web_pages.request, web_vulns.proof and web_vulns.proof to binary.
  #
  # @return [void]
  def up
    rename_column :web_pages, :body, :body_text
    rename_column :web_pages, :request, :request_text
    rename_column :web_vulns, :request, :request_text
    rename_column :web_vulns, :proof, :proof_text

    add_column :web_pages, :body, :binary
    add_column :web_pages, :request, :binary
    add_column :web_vulns, :request, :binary
    add_column :web_vulns, :proof, :binary

    WebPage.find(:all).each { |r| r.body = r.body_text; r.save! }
    WebPage.find(:all).each { |r| r.request = r.request_text; r.save! }
    WebVuln.find(:all).each { |r| r.proof = r.proof_text; r.save! }
    WebVuln.find(:all).each { |r| r.request = r.request_text; r.save! }

    remove_column :web_pages, :body_text
    remove_column :web_pages, :request_text
    remove_column :web_vulns, :request_text
    remove_column :web_vulns, :proof_text

    WebPage.connection.schema_cache.clear!
    WebPage.reset_column_information
    WebVuln.connection.schema_cache.clear!
    WebVuln.reset_column_information
  end
end
