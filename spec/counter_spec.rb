require './lib/counter'

RSpec.describe Counter do
  let(:file) { File.open('spec/support/web.log', 'r') }
  let(:counter) { Counter.new(file) }

  describe 'initialize a counter' do
    context 'with a file' do
      it 'should return a counter object' do
        expect(counter).to be_a(Counter)
      end
    end

    context 'without a file' do
      it 'should raise an error' do
        expect { Counter.new }.to raise_error(ArgumentError)
      end
    end

    context 'initialize an empty page views object' do
      it 'should return an empty hash' do
        expect(counter.page_views).to eq({})
      end
    end

    context 'create page views once run' do
      it 'should return a hash with page views' do
        counter.run
        expect(counter.page_views).to be_a(Hash)
        expect(counter.page_views.keys.length).not_to eq(0)
      end
    end

    context 'show the number of views' do
      it 'show_total_views sorted by total views' do
        counter.run
        expect(counter.show_total_views).to be_truthy
      end

      it 'show_unique_views sorted by unique views' do
        counter.run
        expect(counter.show_unique_views).to be_truthy
      end
    end
  end
end
