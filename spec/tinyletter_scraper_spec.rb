require File.dirname(__FILE__) + "/spec_helper"

describe TinyletterScraper do
  describe "fetch_html" do
    it "should make request to url" do
      tinyletter_scraper = TinyletterScraper.instance
      expect(tinyletter_scraper).to receive(:open).with("http://tinyletter.com/danhon/archive").once
      tinyletter_scraper.fetch_html
    end
  end
  describe "get_links" do
    it "should return an array of the URLS" do
      tinyletter_scraper = TinyletterScraper.instance
      allow(tinyletter_scraper).to receive(:fetch_html) { Nokogiri::HTML(open("./spec/data/hon.html"))}
      expect(tinyletter_scraper.get_links.size).to eq(10)
      expect(tinyletter_scraper.get_links.first).to eq("http://tinyletter.com/danhon/letters/episode-one-hundred-and-twenty-seven-belong-snow-crashing-9-humans-as-a-service")
    end
  end
  describe "save_new_links" do
    before(:each) do
      Link.delete_all
      @tinyletter_scraper = TinyletterScraper.instance
      allow(@tinyletter_scraper).to receive(:get_links) { ["http://new_link"] }
    end
    it "should save new links" do
      expect {
        @tinyletter_scraper.save_new_links        
      }.to change(Link, :count).by(1)
    end

    it "should not create links that already exist" do
      Link.create(:url => "http://new_link")
      expect {
        @tinyletter_scraper.save_new_links        
      }.to change(Link, :count).by(0)
    end
  end
end