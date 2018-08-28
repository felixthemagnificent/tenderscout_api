json.array! @african do |code|
  json.partial! 'v1/dictionaries/industry_codes/code', locals: { code: code, code_name: 'african' }
end
json.array! @classification do |code|
  json.partial! 'v1/dictionaries/industry_codes/code', locals: { code: code, code_name: 'classification' }
end
json.array! @gsin do |code|
  json.partial! 'v1/dictionaries/industry_codes/code', locals: { code: code, code_name: 'gsin' }
end
json.array! @ngip do |code|
  json.partial! 'v1/dictionaries/industry_codes/code', locals: { code: code, code_name: 'ngip' }
end
json.array! @naics do |code|
  json.partial! 'v1/dictionaries/industry_codes/code', locals: { code: code, code_name: 'naics' }
end
json.array! @cpv do |code|
  json.partial! 'v1/dictionaries/industry_codes/code', locals: { code: code, code_name: 'cpv' }
end
# json.array! @sfgov do |code|
#   json.partial! 'v1/dictionaries/industry_codes/code', locals: { code: code, code_name: 'sfgov' }
# end
