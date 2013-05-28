require 'spec_helper'

describe Kuhsaft::PagesController do
  subject { described_class }

  describe '#index' do
    before do
      @pages = [
        create(:page, :title => 'foo'),
        create(:page, :title => 'bar')
      ]
    end

    context 'with search parameter' do
      it 'assigns the search results' do
        get(:index, { :use_route => :kuhsaft, :search => 'foo' })
        assigns(:pages).should eq([@pages.first])
      end
    end
  end

  describe '#show' do
    describe 'redirect' do
      around(:each) do |example|
        I18n.with_locale :de do
          example.run
        end
      end

      context 'when page is not a redirect page' do
        it 'responds with page' do
          page = FactoryGirl.create(:page, :slug => 'dumdidum', :url => 'de/dumdidum')
          get :show,  { :url => page.slug, :use_route => :kuhsaft, :locale => :de }
          assigns(:page).should eq(page)
        end
      end

      context 'when page is a redirect page' do
        it 'redirects to the redirected url' do
          page = FactoryGirl.create(:page, :page_type => 'redirect', :slug => 'dumdidum', :url => 'de/dumdidum', :redirect_url => 'de/redirect_page')
          get :show,  { :url => page.slug, :use_route => :kuhsaft, :locale => :de }
          expect(response).to redirect_to("/de/redirect_page")
        end
      end
    end

    describe 'routing' do
      context 'without url' do
        before do
          @page = FactoryGirl.create(:page, :url_de => 'de')
        end

        context 'with matching locale' do
          it 'sets the corresponding page' do
            I18n.with_locale(:de) do
              get(:show,  { :use_route => :kuhsaft })
            end
            assigns(:page).should eq(@page)
          end
        end

        context 'without matching locale' do
          it 'raises a routing error' do
            I18n.with_locale(:en) do
              expect { get(:show,  { :use_route => :kuhsaft }) }.to raise_error(ActionController::RoutingError)
            end
          end
        end
      end
    end

    describe 'page type' do
      around(:each) do |example|
        I18n.with_locale :de do
          example.run
        end
      end

      context 'when page is not a redirect page' do
        it 'responds with page' do
          page = FactoryGirl.create(:page, :slug => 'dumdidum', :url => 'de/dumdidum')
          get :show,  { :url => page.slug, :use_route => :kuhsaft, :locale => :de }
          assigns(:page).should eq(page)
        end
      end

      context 'when page is a redirect page' do
        it 'redirects to the redirected url' do
          page = FactoryGirl.create(:page, :page_type => 'redirect', :slug => 'dumdidum', :url => 'de/dumdidum', :redirect_url => 'de/redirect_page')
          get :show,  { :url => page.slug, :use_route => :kuhsaft, :locale => :de }
          expect(response).to redirect_to("/de/redirect_page")
        end
      end
    end
  end
end
