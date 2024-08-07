using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CapaEntidad.Stripe
{
    public class PaymentIntent
    {
        public string Id { get; set; }
        public string Object { get; set; }
        public int Amount { get; set; }
        public int AmountCapturable { get; set; }
        public AmountDetails AmountDetails { get; set; }
        public int AmountReceived { get; set; }
        public object Application { get; set; }
        public object ApplicationFeeAmount { get; set; }
        public AutomaticPaymentMethods AutomaticPaymentMethods { get; set; }
        public object CanceledAt { get; set; }
        public object CancellationReason { get; set; }
        public string CaptureMethod { get; set; }
        public string ClientSecret { get; set; }
        public string ConfirmationMethod { get; set; }
        public long Created { get; set; }
        public string Currency { get; set; }
        public object Customer { get; set; }
        public object Description { get; set; }
        public object Invoice { get; set; }
        public object LastPaymentError { get; set; }
        public object LatestCharge { get; set; }
        public bool Livemode { get; set; }
        public Metadata Metadata { get; set; }
        public object NextAction { get; set; }
        public object OnBehalfOf { get; set; }
        public object PaymentMethod { get; set; }
        public PaymentMethodOptions PaymentMethodOptions { get; set; }
        public List<string> PaymentMethodTypes { get; set; }
        public object Processing { get; set; }
        public object ReceiptEmail { get; set; }
        public object Review { get; set; }
        public object SetupFutureUsage { get; set; }
        public object Shipping { get; set; }
        public object Source { get; set; }
        public object StatementDescriptor { get; set; }
        public object StatementDescriptorSuffix { get; set; }
        public string Status { get; set; }
        public object TransferData { get; set; }
        public object TransferGroup { get; set; }
    }

    public class AmountDetails
    {
        public Tip Tip { get; set; }
    }

    public class Tip
    {
    }

    public class AutomaticPaymentMethods
    {
        public bool Enabled { get; set; }
    }

    public class Metadata
    {
    }

    public class PaymentMethodOptions
    {
        public Card Card { get; set; }
        public Link Link { get; set; }
    }

    public class Card
    {
        public object Installments { get; set; }
        public object MandateOptions { get; set; }
        public object Network { get; set; }
        public string RequestThreeDSecure { get; set; }
    }

    public class Link
    {
        public object PersistentToken { get; set; }
    }
}
