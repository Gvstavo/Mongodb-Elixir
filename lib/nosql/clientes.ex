defmodule Nosql.Clientes do

	def insert(map) when is_map(map) do
			
			:mongo
			|> Mongo.insert_one("clients", map)

	end

	def insert(map) when is_list(map) do
			
			:mongo
			|> Mongo.insert_many("clients", map)

	end

	def find, do: :mongo |> Mongo.find("clients", %{}) |> Map.get(:docs)


	def find(filter), do: :mongo |> Mongo.find("clients", filter) |> Map.get(:docs)


	def delete(map) when is_map(map) do
			
			:mongo
			|> Mongo.delete_many("clients", map)

	end

	def delete(map) when is_list(map) do
			
		:mongo
		|> Mongo.delete_many("clients", map)

	end

	def update(old_value , new_value) do
			
		:mongo
		|> Mongo.update_many("clients", old_value , new_value)

	end


end