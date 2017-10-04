require_relative '../f_code'

describe FCode::Interpreter do
  let(:code) { FCode::Code.new code_path }
  let(:interpreter) { FCode::Interpreter.new code }

  describe 'runs pass.fc' do
    let(:code_path) { 'examples/pass.fc' }

    it 'passes input to output' do
      interpreter.input = [1, 2, 3, 4, 5, 6]
      100.times { interpreter.step }
      expect(interpreter.output).to eq [1, 2, 3, 4, 5, 6]
    end
  end

  describe 'runs pass2.fc' do
    let(:code_path) { 'examples/pass2.fc' }

    it 'passes input to output' do
      interpreter.input = [1, 2, 3, 4, 5, 6]
      100.times { interpreter.step }
      expect(interpreter.output).to eq [1, 2, 3, 4, 5, 6]
    end
  end

  describe 'runs swap.fc' do
    let(:code_path) { 'examples/swap.fc' }

    it 'passes input to output' do
      interpreter.input = [1, 2, 3, 4, 5, 6]
      100.times { interpreter.step }
      expect(interpreter.output).to eq [2, 1, 4, 3, 6, 5]
    end
  end

  describe 'runs subtract.fc' do
    let(:code_path) { 'examples/subtract.fc' }

    it 'passes subtracts numbers' do
      interpreter.input = [7, 8, 1, 7, 6, 3]
      100.times { interpreter.step }
      expect(interpreter.output).to eq [7 - 8, 1 - 7, 6 - 3]
    end
  end

  describe 'runs copy.fc' do
    let(:code_path) { 'examples/copy.fc' }

    it 'copies numbers' do
      interpreter.input = [3, 4, 5]
      100.times { interpreter.step }
      expect(interpreter.output).to eq [3, 3, 4, 4, 5, 5]
    end
  end
end
