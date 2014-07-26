class Link < ActiveRecord::Base

  def self.print_unprinted!
    unprinted.each {|l| l.submit_to_paperlater!}
  end

  def self.unprinted
    self.where("sent_to_print_at IS NULL")
  end

  def submit_to_paperlater!
    open("https://paperlater.com/save?#{as_params}")
    self.update_attribute(:sent_to_print_at, Time.now)
  end

  private

  def as_params
    URI.encode_www_form(:token => ENV['PAPERLATER_KEY'], :url => self.url)
  end
end