require 'swagger_helper'

describe 'Making - Main API', swagger_doc: 'v1/swagger.yaml' do

  path '/main/create_theme' do
    post '테마 생성' do
      tags 'Main'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :theme, in: :body, schema: {
        type: :object,
        properties: {
          render_type: { type: :string },
          category: { type: :string }
        }
      }

      response '201', '성공' do
        schema type: :object,
          properties: {
            data: { '$ref' => '#/components/schemas/theme' },
            meta: {
              type: :object,
              properties: {
                # total: { type: :integer }
              }
            }
          }
        
        run_test!
      end
      response '400', '생성 실패: 잘못된 RenderType' do
        run_test!
      end
      response '401', '로그인 필요' do
        run_test!
      end
      response '404', '카테고리를 찾을 수 없음.' do
        run_test!
      end
    end
  end
end