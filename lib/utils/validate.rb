class Validate
  class << self
    def email(str)
      regex = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/
      !!(regex =~ str)
    end

    def password(str)
      !!(/^(?=.*[\D])(?=.*\d)[\D\d]{6,}$/ =~ str)
    end

    def nickname(str)
      !!(/^[가-힣ㄱ-ㅎㅏ-ㅣa-zA-Z0-9]{2,8}$/ =~ str)
    end

    def confirmation(str)
      !!(/^\d{6}$/ =~ str)
    end

    def phone_number(str)
      !!(/^\d{10,11}$/ =~ str)
    end

    def content(str)
      # !!(/\S{5}$/ =~ str)
      str.delete(' ').size >= 5
    rescue
      false
    end
  end
end