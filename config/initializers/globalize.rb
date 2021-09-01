Globalize.fallbacks = {:en => [:en, :ko], :ko => [:ko, :en]}
Globalize::ActiveRecord::Translation.connects_to database: { writing: :new_model }