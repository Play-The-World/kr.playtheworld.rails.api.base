require 'swagger_helper'

describe 'Making - Themes API', swagger_doc: 'v1/swagger.yaml' do

  path '/themes' do
    get '현재 유저의 테마 목록' do
      tags 'Themes'
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
              items: { '$ref' => '#/components/schemas/theme' }
            },
            meta: {
              type: :object,
              properties: {
                total: { type: :integer }
              }
            }
          }
        
        run_test!
      end
      response '401', '로그인 필요' do
        run_test!
      end
    end
  end

  path '/themes/{id}' do
    get '해당 테마의 대한 정보' do
      tags 'Themes'
      produces 'application/json'

      response '200', '성공' do
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
      response '401', '로그인 필요' do
        run_test!
      end
      response '404', '해당 테마를 찾을 수 없음' do
        run_test!
      end
    end

    patch '해당 테마 수정' do
      tags 'Themes'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :theme, in: :body, schema: {
        type: :object,
        properties: {
          theme: { '$ref' => '#/components/schemas/theme' }
        }
      }

      response '200', '성공' do
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
      response '400', '수정 실패' do
        run_test!
      end
      response '401', '로그인 필요' do
        run_test!
      end
      response '404', '해당 테마를 찾을 수 없음' do
        run_test!
      end
    end

    delete '해당 테마 삭제' do
      tags 'Themes'
      produces 'application/json'

      response '200', '성공' do        
        run_test!
      end
      response '400', '삭제 실패' do
        run_test!
      end
      response '401', '로그인 필요' do
        run_test!
      end
      response '404', '해당 테마를 찾을 수 없음' do
        run_test!
      end
    end

    path '/themes/{id}/image' do
      post '해당 테마에 이미지 업로드' do
        tags 'Themes'
        consumes 'application/json'
        produces 'application/json'
        parameter name: :image, in: :body, schema: {
          type: :object,
          properties: {
            type: { type: :string },
            order: { type: :integer },
            file: { type: :string }
          }
        }
  
        response '201', '성공' do
          schema type: :object,
            properties: {
              data: { '$ref' => '#/components/schemas/image' },
              meta: {
                type: :object,
                properties: {
                  # total: { type: :integer }
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
        response '404', '해당 테마를 찾을 수 없음' do
          run_test!
        end
      end

      patch '해당 테마의 이미지 수정' do
        tags 'Themes'
        consumes 'application/json'
        produces 'application/json'
        parameter name: :image, in: :body, schema: {
          type: :object,
          properties: {
            id: { type: :integer }
          }
        }
  
        response '200', '성공' do
          schema type: :object,
            properties: {
              data: { '$ref' => '#/components/schemas/image' },
              meta: {
                type: :object,
                properties: {
                  # total: { type: :integer }
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
        response '404', '해당 테마를 찾을 수 없음' do
          run_test!
        end
        response '404', '해당 이미지 찾을 수 없음' do
          run_test!
        end
      end

      delete '해당 테마의 이미지 삭제' do
        tags 'Themes'
        consumes 'application/json'
        produces 'application/json'
        parameter name: :image, in: :body, schema: {
          type: :object,
          properties: {
            id: { type: :integer }
          }
        }
  
        response '200', '성공' do
          run_test!
        end
        response '400', '삭제 실패' do
          run_test!
        end
        response '401', '로그인 필요' do
          run_test!
        end
        response '404', '해당 테마를 찾을 수 없음' do
          run_test!
        end
        response '404', '해당 이미지 찾을 수 없음' do
          run_test!
        end
      end
    end  
  end
end