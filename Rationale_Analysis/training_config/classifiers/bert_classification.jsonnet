{
  dataset_reader : {
    type : "bert_rationale_reader",
    tokenizer: {
       word_splitter: "bert-basic"
    },
    token_indexers : {
      bert : {
        type : "bert-pretrained",
        pretrained_model : "bert-base-uncased",
        use_starting_offsets: true,
        do_lowercase : true,
      },
    },
  },
  validation_dataset_reader: {
    type : "bert_rationale_reader",
    tokenizer: {
       word_splitter: "bert-basic"
    },
    token_indexers : {
      bert : {
        type : "bert-pretrained",
        pretrained_model : "bert-base-uncased",
        use_starting_offsets: true,
        do_lowercase : true,
      },
    },
  },
  train_data_path: std.extVar('TRAIN_DATA_PATH'),
  validation_data_path: std.extVar('DEV_DATA_PATH'),
  test_data_path: std.extVar('TEST_DATA_PATH'),
  model: {
    type: "bert_rationale_model",
    bert_model: 'bert-base-uncased',
    requires_grad: '11',
    dropout : 0.0,
    rationale_extractor: {
      type : "min_attention",
      min_attention_score : 0.5
    },
    saliency_scorer: {
      type: "simple_gradient"
    },
  },
  iterator: {
    type: "bucket",
    sorting_keys: [["document", "num_tokens"]],
    batch_size : 20
  },
  "trainer": {
    "num_epochs": 40,
    "patience": 5,
    "grad_norm": 10.0,
    "validation_metric": "+accuracy",
    "cuda_device": std.extVar("CUDA_DEVICE"),
    "optimizer": {
      "type": "adam",
      "lr": 2e-5
    }
  },
  "random_seed":  std.parseInt(std.extVar("SEED")),
  "pytorch_seed": std.parseInt(std.extVar("SEED")),
  "numpy_seed": std.parseInt(std.extVar("SEED")),
  "evaluate_on_test": true
}