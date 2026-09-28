defmodule KralukKurkierewicz.ContactEmail do
  @moduledoc """
  The contact-form email: delivers a message submitted through the "Umów
  konsultację" form on the landing page to the kancelaria inbox. Sent through
  Brevo (`Swoosh.Adapters.Brevo`), same as the ordo repository.
  """
  import Swoosh.Email

  alias KralukKurkierewicz.Mailer

  # Verified Brevo sender the message is sent *from*. Must be a domain/address
  # verified in the Brevo account (BREVO_API_KEY).
  @from {"Kraluk Kurkierewicz — formularz", "hello@kkadwokat.pl"}

  # Kancelaria inbox the contact messages land in.
  @recipient {"Kraluk Kurkierewicz", "kontakt@kkadwokat.pl"}

  @doc """
  Builds and delivers the contact message. `params` is a map with the form
  fields `"name"`, `"contact"` and `"message"`.
  """
  def deliver(%{"name" => name, "contact" => contact, "message" => message}) do
    email =
      new()
      |> to(@recipient)
      |> from(@from)
      |> reply_to(reply_to_address(contact, name))
      |> subject("Nowa wiadomość z formularza — #{name}")
      |> text_body(text_body(name, contact, message))
      |> html_body(html_body(name, contact, message))

    Mailer.deliver(email)
  end

  # Use the visitor's contact as reply-to only when it looks like an email;
  # otherwise (a phone number) fall back to the kancelaria address.
  defp reply_to_address(contact, name) do
    if String.contains?(contact, "@"), do: {name, String.trim(contact)}, else: @recipient
  end

  defp text_body(name, contact, message) do
    """
    Nowa wiadomość z formularza kontaktowego.

    Imię i nazwisko: #{name}
    E-mail lub telefon: #{contact}

    Treść:
    #{message}
    """
  end

  defp html_body(name, contact, message) do
    """
    <!DOCTYPE html>
    <html lang="pl">
      <body style="margin:0;padding:0;background:#f4f6f8;font-family:-apple-system,'Segoe UI',Roboto,Helvetica,Arial,sans-serif;color:#16233b;">
        <table role="presentation" width="100%" cellpadding="0" cellspacing="0" style="background:#f4f6f8;padding:32px 0;">
          <tr>
            <td align="center">
              <table role="presentation" width="520" cellpadding="0" cellspacing="0" style="max-width:520px;width:100%;background:#ffffff;border:1px solid #e2e8f0;">
                <tr>
                  <td style="padding:28px;">
                    <p style="margin:0 0 20px;font-weight:700;font-size:20px;color:#16233b;">Nowa wiadomość z formularza</p>

                    <p style="margin:0 0 4px;font-size:11px;letter-spacing:0.15em;color:#5a6a85;">IMIĘ I NAZWISKO</p>
                    <p style="margin:0 0 16px;font-size:15px;">#{escape(name)}</p>

                    <p style="margin:0 0 4px;font-size:11px;letter-spacing:0.15em;color:#5a6a85;">E-MAIL LUB TELEFON</p>
                    <p style="margin:0 0 16px;font-size:15px;">#{escape(contact)}</p>

                    <p style="margin:0 0 4px;font-size:11px;letter-spacing:0.15em;color:#b8860b;">TREŚĆ</p>
                    <div style="margin:0;padding:14px 16px;background:#f4f6f8;border:1px solid #e2e8f0;color:#2b3a57;font-size:14px;line-height:1.5;white-space:pre-wrap;">#{escape(message)}</div>
                  </td>
                </tr>
              </table>
            </td>
          </tr>
        </table>
      </body>
    </html>
    """
  end

  defp escape(nil), do: ""

  defp escape(text) do
    text
    |> to_string()
    |> String.replace("&", "&amp;")
    |> String.replace("<", "&lt;")
    |> String.replace(">", "&gt;")
  end
end
