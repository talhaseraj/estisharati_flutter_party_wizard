// To parse this JSON data, do
//
//     final paymentIntentResponse = paymentIntentResponseFromJson(jsonString);

import 'dart:convert';

PaymentIntentResponse paymentIntentResponseFromJson(String str) => PaymentIntentResponse.fromJson(json.decode(str));


class PaymentIntentResponse {
    int? status;
    String? message;
    Data? data;

    PaymentIntentResponse({
        this.status,
        this.message,
        this.data,
    });

    factory PaymentIntentResponse.fromJson(Map<String, dynamic> json) => PaymentIntentResponse(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
    );


}

class Data {
    String? id;
    String? object;
    int? amount;
    int? amountCapturable;
    AmountDetails? amountDetails;
    int? amountReceived;
    dynamic application;
    dynamic applicationFeeAmount;
    AutomaticPaymentMethods? automaticPaymentMethods;
    dynamic canceledAt;
    dynamic cancellationReason;
    String? captureMethod;
    String? clientSecret;
    String? confirmationMethod;
    int? created;
    String? currency;
    dynamic customer;
    dynamic description;
    dynamic invoice;
    dynamic lastPaymentError;
    dynamic latestCharge;
    bool? livemode;
    List<dynamic>? metadata;
    dynamic nextAction;
    dynamic onBehalfOf;
    dynamic paymentMethod;
    PaymentMethodConfigurationDetails? paymentMethodConfigurationDetails;
    PaymentMethodOptions? paymentMethodOptions;
    List<String>? paymentMethodTypes;
    dynamic processing;
    dynamic receiptEmail;
    dynamic review;
    dynamic setupFutureUsage;
    dynamic shipping;
    dynamic source;
    dynamic statementDescriptor;
    dynamic statementDescriptorSuffix;
    String? status;
    dynamic transferData;
    dynamic transferGroup;

    Data({
        this.id,
        this.object,
        this.amount,
        this.amountCapturable,
        this.amountDetails,
        this.amountReceived,
        this.application,
        this.applicationFeeAmount,
        this.automaticPaymentMethods,
        this.canceledAt,
        this.cancellationReason,
        this.captureMethod,
        this.clientSecret,
        this.confirmationMethod,
        this.created,
        this.currency,
        this.customer,
        this.description,
        this.invoice,
        this.lastPaymentError,
        this.latestCharge,
        this.livemode,
        this.metadata,
        this.nextAction,
        this.onBehalfOf,
        this.paymentMethod,
        this.paymentMethodConfigurationDetails,
        this.paymentMethodOptions,
        this.paymentMethodTypes,
        this.processing,
        this.receiptEmail,
        this.review,
        this.setupFutureUsage,
        this.shipping,
        this.source,
        this.statementDescriptor,
        this.statementDescriptorSuffix,
        this.status,
        this.transferData,
        this.transferGroup,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        object: json["object"],
        amount: json["amount"],
        amountCapturable: json["amount_capturable"],
        amountDetails: AmountDetails.fromJson(json["amount_details"]),
        amountReceived: json["amount_received"],
        application: json["application"],
        applicationFeeAmount: json["application_fee_amount"],
        automaticPaymentMethods: AutomaticPaymentMethods.fromJson(json["automatic_payment_methods"]),
        canceledAt: json["canceled_at"],
        cancellationReason: json["cancellation_reason"],
        captureMethod: json["capture_method"],
        clientSecret: json["client_secret"],
        confirmationMethod: json["confirmation_method"],
        created: json["created"],
        currency: json["currency"],
        customer: json["customer"],
        description: json["description"],
        invoice: json["invoice"],
        lastPaymentError: json["last_payment_error"],
        latestCharge: json["latest_charge"],
        livemode: json["livemode"],
        metadata: List<dynamic>.from(json["metadata"].map((x) => x)),
        nextAction: json["next_action"],
        onBehalfOf: json["on_behalf_of"],
        paymentMethod: json["payment_method"],
        paymentMethodConfigurationDetails: PaymentMethodConfigurationDetails.fromJson(json["payment_method_configuration_details"]),
        paymentMethodOptions: PaymentMethodOptions.fromJson(json["payment_method_options"]),
        paymentMethodTypes: List<String>.from(json["payment_method_types"].map((x) => x)),
        processing: json["processing"],
        receiptEmail: json["receipt_email"],
        review: json["review"],
        setupFutureUsage: json["setup_future_usage"],
        shipping: json["shipping"],
        source: json["source"],
        statementDescriptor: json["statement_descriptor"],
        statementDescriptorSuffix: json["statement_descriptor_suffix"],
        status: json["status"],
        transferData: json["transfer_data"],
        transferGroup: json["transfer_group"],
    );


}

class AmountDetails {
    List<dynamic>? tip;

    AmountDetails({
        this.tip,
    });

    factory AmountDetails.fromJson(Map<String, dynamic> json) => AmountDetails(
        tip: List<dynamic>.from(json["tip"].map((x) => x)),
    );

 
}

class AutomaticPaymentMethods {
    String? allowRedirects;
    bool? enabled;

    AutomaticPaymentMethods({
        this.allowRedirects,
        this.enabled,
    });

    factory AutomaticPaymentMethods.fromJson(Map<String, dynamic> json) => AutomaticPaymentMethods(
        allowRedirects: json["allow_redirects"],
        enabled: json["enabled"],
    );

    Map<String, dynamic> toJson() => {
        "allow_redirects": allowRedirects,
        "enabled": enabled,
    };
}

class PaymentMethodConfigurationDetails {
    String? id;
    dynamic parent;

    PaymentMethodConfigurationDetails({
        this.id,
        this.parent,
    });

    factory PaymentMethodConfigurationDetails.fromJson(Map<String, dynamic> json) => PaymentMethodConfigurationDetails(
        id: json["id"],
        parent: json["parent"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "parent": parent,
    };
}

class PaymentMethodOptions {
    Card? card;

    PaymentMethodOptions({
        this.card,
    });

    factory PaymentMethodOptions.fromJson(Map<String, dynamic> json) => PaymentMethodOptions(
        card: Card.fromJson(json["card"]),
    );

  
}

class Card {
    dynamic installments;
    dynamic mandateOptions;
    dynamic network;
    String? requestThreeDSecure;

    Card({
        this.installments,
        this.mandateOptions,
        this.network,
        this.requestThreeDSecure,
    });

    factory Card.fromJson(Map<String, dynamic> json) => Card(
        installments: json["installments"],
        mandateOptions: json["mandate_options"],
        network: json["network"],
        requestThreeDSecure: json["request_three_d_secure"],
    );

}
