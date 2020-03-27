module V1::CRUDDocs
  extend ActiveSupport::Concern

  included do
    api! "목록"
    param :page, Integer, desc: "페이지 번호", default_value: 1
    returns code: 200 do
      param_group :response
    end
    def index
      # ...
    end

    api! "생성"
    returns code: 200 do
      param_group :concern
    end
    def create
      # ...
    end
  
    api! "조회"
    returns code: 200 do
      param_group :response
    end
    def show
      # ...
    end
  
    api! "수정"
    returns code: 200 do
      param_group :response
    end
    def update
      # ...
    end

    api! "삭제"
    def destroy
      # ...
    end
  end
end