defmodule PopovChat.Bucket do
  alias ExAws.S3

  @folder_base "/images/"

  def upload_image(%Plug.Upload{} = file, file_name) do
    file.path
      |> S3.Upload.stream_file
      |> S3.upload(bucket_name(), prevent_full_aws_url(file_name))
      |> ExAws.request
  end

  def remove_image(file_name) do
    S3.delete_object(bucket_name(), @folder_base <> file_name)
      |> ExAws.request
  end

  def build_full_url(file_name), do: "#{url_base()}#{@folder_base}#{file_name}"
  defp prevent_full_aws_url(full_url), do: String.replace(full_url, url_base(), "")

  defp bucket_name, do: Application.get_env(:popov_chat, :bucket_name)
  defp url_base, do: Application.get_env(:popov_chat, :s3_url_base)

end
