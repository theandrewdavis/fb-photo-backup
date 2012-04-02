require_relative 'spec_helper'
require_relative '../lib/downloader'

describe Downloader do
  before :all do
    load_fixtures
  end

  let(:mock_logger) { stub(download_progress: nil) }
  let(:mock_stream) { stub(read: 'mock stream') }
  let(:downloader) { Downloader.new(mock_logger) }

  it 'should download a link' do
    downloader.expects(:open).once.yields(mock_stream)
    Dir.mktmpdir do |tmpdir|
      downloader.download(tmpdir, [@clean_link])
      Dir.new(tmpdir).include?(@image_name).should eq(true)
    end
  end

  it 'should skip already-downloaded files' do
    downloader.expects(:open).never
    Dir.mktmpdir do |tmpdir|
      FileUtils.touch(File.join(tmpdir, @image_name))
      downloader.download(tmpdir, [@clean_link])
    end
  end
end
