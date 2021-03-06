describe "Deducer" do
  context "controller" do
    let(:deducer) do
      Jets::Processors::Deducer.new("handlers/controllers/posts_controller.create")
    end

    it "deduces info to run the ruby code" do
      expect(deducer.process_type).to include("controller")
      expect(deducer.path).to include("app/controllers/posts_controller.rb")
      expect(deducer.code).to eq %Q|PostsController.process(event, context, "create")|
    end
  end

  context "job" do
    let(:deducer) do
      Jets::Processors::Deducer.new("handlers/jobs/hard_job.dig")
    end

    it "deduces info to run the ruby code" do
      expect(deducer.process_type).to include("job")
      expect(deducer.path).to include("app/jobs/hard_job.rb")
      expect(deducer.code).to eq %Q|HardJob.process(event, context, "dig")|
    end
  end

  context "function with _function" do
    let(:deducer) do
      Jets::Processors::Deducer.new("handlers/functions/hello_function.world")
    end

    it "deduces info to run the ruby code" do
      expect(deducer.process_type).to include("function")
      expect(deducer.path).to include("app/functions/hello_function.rb")
      expect(deducer.code).to eq %Q|HelloFunction.process(event, context, "world")|
    end
  end

  context "function without _function" do
    let(:deducer) do
      Jets::Processors::Deducer.new("handlers/functions/hello.world")
    end

    it "deduces info to run the ruby code" do
      expect(deducer.process_type).to include("function")
      expect(deducer.path).to include("app/functions/hello.rb")
      expect(deducer.code).to eq %Q|Hello.process(event, context, "world")|
    end
  end

  context "shared function" do
    let(:deducer) do
      Jets::Processors::Deducer.new("handlers/shared/functions/whatever.handle")
    end

    it "deduces info to run the ruby code" do
      expect(deducer.process_type).to include("function")
      expect(deducer.path).to include("app/shared/functions/whatever.rb")
      expect(deducer.code).to eq %Q|Whatever.process(event, context, "handle")|
    end
  end
end
