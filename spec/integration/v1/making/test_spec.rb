require 'swagger_helper'

describe 'Making - Test API', swagger_doc: 'v1/swagger.yaml' do

  path '/test/themes' do
    post '테마 목록' do
      tags 'Test'
      produces 'application/json'

      response '200', '성공' do
        schema type: :object,
          properties: {
            data: {
              type: :array,
              items: {
                type: :object,
                properties: {
                  theme_number: { type: :integer },
                  value: { type: :string }
                }
              }
            }
          }
        
        run_test!
      end
      response '400', '실패' do
        run_test!
      end
      response '401', '로그인 필요' do
        run_test!
      end
    end
  end

  path '/test/themes/{id}' do
    post '테마 생성' do
      tags 'Test'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :data, in: :body, schema: {
        type: :object,
        properties: {
          render_type: { type: :string },
          category: { type: :string }
        }
      }

      response '201', '성공' do
        schema type: :object,
          properties: {
            data: {
              type: :object,
              properties: {
                theme_number: { type: :integer },
                value: { type: :string }
              }
            }
          }
        
        run_test!
      end
      response '400', '생성 실패' do
        run_test!
      end
      response '401', '로그인 필요' do
        run_test!
      end
    end

    get '테마 조회' do
      tags 'Test'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :data, in: :body, schema: {
        type: :object,
        properties: {
          render_type: { type: :string },
          category: { type: :string }
        }
      }

      response '201', '성공' do
        schema type: :object,
          properties: {
            data: {
              type: :object,
              properties: {
                theme_number: { type: :integer },
                value: { type: :string }
              }
            }
          }
        
        run_test!
      end
      response '400', '생성 실패' do
        run_test!
      end
      response '401', '로그인 필요' do
        run_test!
      end
      response '404', '테마를 찾을 수 없음.' do
        run_test!
      end
    end

  end
end