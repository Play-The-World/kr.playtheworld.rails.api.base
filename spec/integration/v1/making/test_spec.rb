require 'swagger_helper'

describe 'Making - Test API', swagger_doc: 'v1/swagger.yaml' do

  path '/test/theme_list' do
    get '테마 목록' do
      tags 'Test'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :theme, in: :body, schema: {
        type: :object,
        properties: {
          items: { type: :integer },
          page: { type: :integer }
        }
      }

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

  path '/test/themes' do
    post '테마 생성' do
      tags 'Test'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :data, in: :body, schema: {
        type: :object,
        properties: {
          data: { type: :string }
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
      response '404', '필수 요소 themeNumber 부재' do
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
          data: { type: :string }
        }
      }

      response '200', '성공' do
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
      response '400', '조회 실패' do
        run_test!
      end
      response '401', '로그인 필요' do
        run_test!
      end
      response '404', '테마를 찾을 수 없음.' do
        run_test!
      end
    end

    patch '테마 수정' do
      tags 'Test'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :data, in: :body, schema: {
        type: :object,
        properties: {
          data: { type: :string }
        }
      }

      response '200', '성공' do
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
      response '400', '수정 실패' do
        run_test!
      end
      response '401', '로그인 필요' do
        run_test!
      end
      response '404', '테마를 찾을 수 없음.' do
        run_test!
      end
    end

    delete '테마 삭제' do
      tags 'Test'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :data, in: :body, schema: {
        type: :object,
        properties: {
          data: { type: :string }
        }
      }

      response '200', '성공' do
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
      response '400', '조회 실패' do
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

  path '/test/images' do
    post '이미지 업로드' do
      tags 'Test'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :images, in: :body, schema: {
        type: :object,
        properties: {
          images: {
            type: :array,
            items: { type: :string }
          }
        }
      }

      response '200', '성공' do
        schema type: :object,
          properties: {
            data: {
              type: :array,
              items: {
                type: :object,
                properties: {
                  id: { type: :integer },
                  url: { type: :string },
                  content_type: { type: :string },
                  filename: { type: :string },
                  size: { type: :integer }
                }
              }
            }
          }
        
        run_test!
      end
      response '400', '실패' do
        run_test!
      end
    end
  end
end