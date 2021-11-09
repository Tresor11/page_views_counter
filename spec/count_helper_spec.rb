# frozen_string_literal: true

require './lib/counter_helper'

RSpec.describe CounterHelper do
  let(:helper) { CounterHelper }
  let(:page_set) { {} }

  describe 'add_new_page' do
    context 'when page does not exist' do
      it 'should create a new page' do
        helper.add_new_page(page_set, 'page1', '001')
        expect(page_set.keys).to include('page1')
        expect(page_set['page1'][:total_views]).to eq(1)
        expect(page_set['page1'][:unique_views]).to eq(1)
        expect(page_set['page1'][:visits_ips].keys).to include(:'001')
      end
    end
  end

  describe 'add_page' do
    context 'when page exists' do
      it 'should update the page' do
        helper.add_new_page(page_set, 'page1', '001')
        helper.add_page(page_set, 'page1')
        expect(page_set['page1'][:total_views]).to eq(2)
      end
    end
  end

  describe 'new_page?' do
    context 'when page is new' do
      it 'should return true' do
        helper.add_new_page(page_set, 'page1', '001')
        expect(helper.new_page?(page_set, 'page2')).to be true
      end
    end

    context 'when page is not new' do
      it 'should return false' do
        helper.add_new_page(page_set, 'page1', '001')
        expect(helper.new_page?(page_set, 'page1')).to be false
      end
    end
  end

  describe 'unique_ip?' do
    context 'when the visitor is not new' do
      it 'should return false' do
        helper.add_new_page(page_set, 'page1', '001')
        helper.add_page(page_set, 'page1')
        expect(helper.unique_ip?(page_set, 'page1', '001')).to be false
      end
    end

    context 'when the visitor is new' do
      it 'should return true' do
        helper.add_new_page(page_set, 'page1', '001')
        expect(helper.unique_ip?(page_set, 'page1', '002')).to be true
      end
    end
  end

  describe 'add_unique_ip' do
    describe 'add_unique_ip' do
      it 'should not add a new visitor' do
        helper.add_new_page(page_set, 'page1', '001')
        helper.add_unique_ip(page_set, 'page1', '002')
        expect(page_set['page1'][:unique_views]).to eq(2)
        expect(page_set['page1'][:visits_ips].keys).to eq(%i[001 002])
      end
    end
  end
end
