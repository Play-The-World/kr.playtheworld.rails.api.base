require 'swagger_helper'

describe 'Making - Edit API', swagger_doc: 'v1/swagger.yaml' do

  path '/edit/{id}/stage_lists' do
    post '스테이지 리스트 수정' do
      tags 'Edit'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :stage_list, in: :body, schema: {
        type: :object,
        properties: {
          stage_lists: {
            type: :array,
            items: {
              type: :object,
              properties: {
                title: { type: :string },
                type: { type: :string },
                stageListNo: { type: :integer }
              }
            }
          }
        }
      }

      response '200', '성공' do
        schema type: :object,
          properties: {
            # data: { '$ref' => '#/components/schemas/stage_list' },
            data: {
              type: :array,
              items: {
                type: :object,
                properties: {
                  title: { type: :string },
                  type: { type: :string },
                  stageListNo: { type: :integer }
                }
              }
            },
            meta: {
              type: :object,
              properties: {
                # total: { type: :integer }
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
      response '404', '해당 테마를 찾을 수 없음' do
        run_test!
      end
    end
  end

  path '/edit/{id}/image' do
    post '해당 테마에 이미지 업로드' do
      tags 'Edit'
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
      tags 'Edit'
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
      tags 'Edit'
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