require 'swagger_helper'

describe 'Making - Sessions API', swagger_doc: 'v1/swagger.yaml' do

  path '/sessions/current_user' do
    get '현재 유저 정보' do
      tags 'Sessions'
      produces 'application/json'

      response '200', '현재 유저 정보 표시' do
        examples 'application/json' => {
          data: {
            user: {
              email: "string"
            }
          }
        }
        run_test!
      end
    end
  end

  path '/sessions/email' do
    get 'E-mail 가입 여부 확인' do
      tags 'Sessions'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          user: {
            type: :object,
            properties: {
              email: { type: :string }
            }
          }
        },
        required: [ 'user[email]' ]
      }

      response '200', '아직 가입 안된 이메일' do
        run_test!
      end
      response '201', '이미 가입된 이메일' do
        run_test!
      end
    end
  end

  path '/sessions/sign_in' do
    post '로그인' do
      tags 'Sessions'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          user: {
            type: :object,
            properties: {
              email: { type: :string },
              password: { type: :string }
            }
          }
        },
        required: [ 'user[email]', 'user[password]' ]
      }

      response '200', '로그인 성공' do
        run_test!
      end
      response '400', '이미 로그인 중' do
        run_test!
      end
      response '401', '비밀번호 틀림' do
        run_test!
      end
      response '404', '아직 가입되지 않은 이메일' do
        run_test!
      end
    end
  end

  path '/sessions/sign_up' do
    post '회원 가입' do
      tags 'Sessions'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          user: {
            type: :object,
            properties: {
              email: { type: :string },
              password: { type: :string }
            }
          }
        },
        required: [ 'user[email]', 'user[password]' ]
      }

      response '200', '회원 가입 성공' do
        run_test!
      end
      response '400', '이미 로그인 중' do
        run_test!
      end
      response '403', '이미 가입한 이메일' do
        run_test!
      end
    end
  end

  path '/sessions/confirm_email' do
    post 'E-mail 인증' do
      tags 'Sessions'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          user: {
            type: :object,
            properties: {
              email_confirmation: { type: :string }
            }
          }
        },
        required: [ 'user[email_confirmation]' ]
      }

      response '200', '이메일 인증 성공' do
        run_test!
      end
      response '400', '잘못된 요청' do
        run_test!
      end
      response '401', '세션데이터 유실' do
        run_test!
      end
      response '403', '잘못된 인증번호' do
        run_test!
      end
    end
  end

  path '/sessions/sign_out' do
    delete '로그아웃' do
      tags 'Sessions'
      produces 'application/json'

      response '200', '로그아웃 성공' do
        run_test!
      end
      response '401', '로그인 필요' do
        run_test!
      end
    end
  end

  path '/sessions/nickname' do
    patch '닉네임 변경' do
      tags 'Sessions'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          user: {
            type: :object,
            properties: {
              nickname: { type: :string }
            }
          }
        },
        required: [ 'user[nickname]' ]
      }

      response '200', '닉네임 변경 성공' do
        run_test!
      end
      response '202', '변경 사항 없음' do
        run_test!
      end
      response '400', '중복된 닉네임' do
        run_test!
      end
      response '401', '로그인 필요' do
        run_test!
      end
    end

    path '/sessions/password' do
      patch '비밀번호 변경' do
        tags 'Sessions'
        consumes 'application/json'
        produces 'application/json'
        parameter name: :user, in: :body, schema: {
          type: :object,
          properties: {
            user: {
              type: :object,
              properties: {
                password: { type: :string },
                password_confirmation: { type: :string }
              }
            }
          },
          required: [ 'user[password]', 'user[password_confirmation]' ]
        }
  
        response '200', '비밀번호 변경 성공' do
          run_test!
        end
        response '400', '비밀번호 & 비밀번호 확인 불일치' do
          run_test!
        end
        response '401', '로그인 필요' do
          run_test!
        end
      end
    end

    path '/sessions/email' do
      patch '이메일 변경' do
        tags 'Sessions'
        consumes 'application/json'
        produces 'application/json'
        parameter name: :user, in: :body, schema: {
          type: :object,
          properties: {
            user: {
              type: :object,
              properties: {
                email: { type: :string }
              }
            }
          },
          required: [ 'user[email]' ]
        }
  
        response '200', '이메일 변경 성공' do
          run_test!
        end
        response '202', '변경사항 없음' do
          run_test!
        end
        response '400', '알 수 없는 에러' do
          run_test!
        end
        response '401', '로그인 필요' do
          run_test!
        end
        response '403', '이미 가입된 이메일(중복)' do
          run_test!
        end
      end
    end
  end
end