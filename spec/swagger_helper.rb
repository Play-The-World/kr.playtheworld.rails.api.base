# frozen_string_literal: true

require 'rails_helper'

RSpec.configure do |config|
  # Specify a root folder where Swagger JSON files are generated
  # NOTE: If you're using the rswag-api to serve API descriptions, you'll need
  # to ensure that it's configured to serve Swagger from the same folder
  config.swagger_root = Rails.root.join('swagger').to_s

  # Define one or more Swagger documents and provide global metadata for each one
  # When you run the 'rswag:specs:swaggerize' rake task, the complete Swagger will
  # be generated at the provided relative path under swagger_root
  # By default, the operations defined in spec files are added to the first
  # document below. You can override this behavior by adding a swagger_doc tag to the
  # the root example_group in your specs, e.g. describe '...', swagger_doc: 'v2/swagger.json'
  config.swagger_docs = {
    'v1/swagger.yaml' => {
      openapi: '3.0.1',
      info: {
        title: 'PLAYTHEWORLD API V1',
        version: 'v1',
        description: '플레이더월드 API 문서입니다.'
      },
      paths: {},
      servers: [
        {
          url: 'http://api.playthe.world/v1/making',
          description: 'Production Server - Making'
          # variables: {
          #   defaultHost: {
          #     default: ''
          #   }
          # }
        },
        {
          url: 'http://localhost:3000/v1/making',
          description: 'Development Server - Making'
        }
      ],
      components: {
        schemas: {
          image: {
            type: :object,
            properties: {
              id: { type: :integer },
              type: { type: :string },
              order: { type: :integer },
              url: { type: :string }
            }
          },
          theme: {
            type: 'object',
            properties: {
              id: { type: 'string' },
              themeTitle: { type: 'string' },
              themeDescription: { type: 'string' },
              themeProfile: {
                type: 'object',
                properties: {
                  fileName: { type: 'string' },
                  imageUrl: { type: 'string' }
                }
              },
              themeType: { type: 'string' },
              playType: { type: 'string' },
              onOffType: { type: 'string' },
              addFunction: {
                type: 'object',
                properties: {
                  attention: {
                    type: 'object',
                    properties: {
                      brifEmphasisMessage: { type: 'string' },
                      emphasisMessage: { type: 'string' },
                      getUserAgree: { type: 'boolean' },
                      isUse: { type: 'boolean' }
                    }
                  },
                  dueDate: {
                    type: 'object',
                    properties: {
                      endDate: { type: 'string' },
                      isUse: { type: 'boolean' }
                    }
                  },
                  infoMessage: {
                    type: 'object',
                    properties: {
                      message: { type: 'string' },
                      isUse: { type: 'boolean' }
                    }
                  },
                  memo: { type: 'boolean' },
                  rank: { type: 'boolean' },
                  review: { type: 'boolean' }
                }
              },
              addInfoText: { type: 'string' },
              dateOfApplication: { type: 'string' },
              dateOfCreate: { type: 'string' },
              dateOfEdit: { type: 'string' },
              genre: { type: 'string' },
              level: { type: 'string' },
              participant: { type: 'integer' },
              playTime: { type: 'integer' },
              themeProfile: {
                type: 'object',
                properties: {
                  alarm: { type: 'boolean' },
                  status: { type: 'string' },
                  type: { type: 'string' }
                }
              },
              numberOfEnding: { type: 'integer' },
              # soundInfo: {
              #   type: 'object'
              #   properties: {
              #     background: {
              #       type: 'object'
              #       properties: {
              #         auto: { type: 'boolean' },
              #         repeat: { type: 'boolean' }
              #         start: {
              #           type: 'object'
              #           properties: {
              #             stageNo: { type: 'integer' },
              #             isUse: { type: 'boolean' }
              #           }
              #         },
              #       }
              #     }
              #   }
              # },
              themeImageInfo: {
                type: 'object',
                properties: {
                  # fileNameList: { type: 'boolean' },
                  imageURLList: {
                    type: 'array',
                    items: { type: 'string' }
                  }
                }
              },
              themePrice: {
                type: 'object',
                properties: {
                  freeStage: { type: 'boolean' },
                  priceType: { type: 'string' },
                  selectPrice: { type: 'integer' },
                  themeType: { type: 'string' }
                }
              },
              writters: {
                type: 'object',
                properties: {
                  made: { type: 'string' },
                  picture: {
                    type: 'array',
                    items: { type: 'string' }
                  },
                  text: {
                    type: 'array',
                    items: { type: 'string' }
                  }
                }
              },
              startPosition: {
                type: 'object',
                properties: {
                  address: { type: 'string' },
                  description: { type: 'string' },
                  lat: { type: 'string' },
                  lng: { type: 'string' }
                }
              }
            }
          }
        }
      }
    }
  }

  # Specify the format of the output Swagger file when running 'rswag:specs:swaggerize'.
  # The swagger_docs configuration option has the filename including format in
  # the key, this may want to be changed to avoid putting yaml in json files.
  # Defaults to json. Accepts ':json' and ':yaml'.
  config.swagger_format = :yaml
end
