require 'rails_helper'

RSpec.describe Tickets::CsvStorage do
  subject(:service) { described_class.new(file_path: tmp_file_path) }

  let(:tmp_file_path) do
    file = Tempfile.new(['test', '.csv'])
    path = file.path

    file.unlink

    path
  end

  let(:data) do
    {
      first_name: 'John',
      last_name: 'Dou',
    }
  end

  describe '#write' do
    it 'writes data to CSV file' do
      service.write(data)

      content = File.read(tmp_file_path)

      expect(content).to eq("first_name,last_name\nJohn,Dou\n")
    end
  end

  describe '#read' do
    before { service.write(data) }

    it 'read data from CSV file' do
      expect(service.read).to eq([{"first_name" => "John", "last_name" => "Dou"}])
    end
  end

  describe '#clean' do
    before { service.write(data) }

    it 'deletes storage file' do
      expect(File.exist?(tmp_file_path)).to be_truthy
      service.clean
      expect(File.exist?(tmp_file_path)).to be_falsey
    end
  end
end
